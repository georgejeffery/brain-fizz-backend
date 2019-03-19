class Api::V1::NotesController < API::V1::BaseController

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  before_action :authenticate_request!, only: [:get_user_notes]

  def not_found(e)
    render json: {error: e.to_s}, status: :bad_request
  end
''
  def show
    note = Note.find(params[:id])
    render json: note, serializer: NoteSerializer
  end

  def index
    notes = Note.all
    render json: notes, each_serializer: NoteSerializer
  end

  def create
    # byebug
    @note = Note.new(note_params)
    tags = params[:tags]
    taggroup = []
    tags.each do |tag|
      taggroup.push(Tag.find(tag["id"]))
    end
    @note.tags.push(taggroup)
    @note.tone = @note.get_tone
    
    if @note.save
      render json:@note, status: :created,  serializer: NoteSerializer
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  def get_user_notes
    
    @notes = Note.where(user_id: params[:user_id])
    render json: @notes, each_serializer: NoteSerializer
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy

    render :json => {message: "Success"}, status: :ok
  end

 


  private

  def note_params
    params.permit(:title,:content,:user_id,{tags: []},:date)
  end
end

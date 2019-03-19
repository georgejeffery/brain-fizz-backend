class Api::V1::TagsController < API::V1::BaseController

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found(e)
    render json: {error: e.to_s}, status: :bad_request
  end

  def show
    tag = Tag.find(params[:id])
    render json: tag, serializer: TagSerializer
  end

  def index
    tag = Tag.all
    render json: tag, each_serializer: TagSerializer
  end

  def create
    tag = Tag.new(tag_params)

    if tag.save
      render json: tag, each_serializer: TagSerializer
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  private


  def tag_params
    params.permit(:name)
  end
end

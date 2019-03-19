class Api::V1::UsersController < API::V1::BaseController
  
  before_action :authenticate_request!, only: [:show]
  
  def index
    users = User.all
    render json: users, each_serializer: UserSerializer
  end

  def show
    user = User.find(params[:id])
    render json: user, serializer: UserSerializer
  end

  def create
    # byebug
    @user = User.new(user_params)
    
    if @user.save
      render json:@user, status: :created,  serializer: UserSerializer
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update(user_params)
      render json:@user, status: :ok,  serializer: UserSerializer
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.notes.destroy_all
    @user.destroy

    render :json => {message: "Success"}, status: :ok
  end


  def get_tone_of_day
    @user = User.find(params[:id])
    
    #date params must be dd/mm/yyyy
    date = params[:date].to_date
    tone = @user.getTone(date)
    #byebug
    render :json => {tone: tone}
  end

  private

  def user_params
    params.permit(:name, :phone_number, :password, :username)
  end

end

class Api::UsersController < ApiController
  
  before_action :authenticated?

  def index
    return permission_denied_error unless conditions_met

    users = User.all

    render json: users, each_serializer: UserSerializer 
  end

  # def index

  #    render json: users, each_serializer: UserSerializer 
  # end

  def create
     puts user_params
     user = User.new (user_params)
     if user.save
       render json: user.to_json
     else
      # # 5
       render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
     end
  end

  def destroy
    begin
      user = User.find(params[:id])
      user.destroy
  # #1
      render json: {}, status: :no_content
    rescue ActiveRecord::RecordNotFound
      render :json => {}, :status => :not_found
    end
  end

  private

  def conditions_met
    true # We're not calling this an InsecureUserSerializer for nothing
  end

  def user_params
     params.require(:user).permit(:name, :email, :password)
   end
end
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
     user = User.new(user_params)
     if user.save
       render json: user.to_json
     else
      # # 5
       render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
     end
  end

  private

  def conditions_met
    true # We're not calling this an InsecureUserSerializer for nothing
  end

  def user_params
     params.require(:user).permit(:username, :password)
   end
end
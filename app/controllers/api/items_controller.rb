class Api::ItemsController < ApiController
  before_action :authenticated?

  def index
    return permission_denied_error unless conditions_met

    items = Item.all

    render json: items, each_serializer: ItemSerializer
  end

  def create
  end

  private

  def conditions_met
    true # We're not calling this an InsecureUserSerializer for nothing
  end

  # def user_params
  #   params.require(:user).permit(:username, :password)
  # end
end
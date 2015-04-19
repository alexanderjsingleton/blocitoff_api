class Api::ItemsController < ApiController
  before_action :authenticated?

  def index
    return permission_denied_error unless conditions_met

    items = Item.all

    render json: items, each_serializer: ItemSerializer
  end

  # def create
  #   @list = List.find(params[:list_id])
  #   @item = @list.items.build(item_params)

  #   if @item.save
  #     render json: @item, each_serializer: ItemSerializer
  #   else
  #     render json: @item.errors, status: :unprocessable_entity
  #   end
  # end

   def create
    puts current_user
    @list = current_user.lists.build(list_params)
    if @list.save
      render json: @list, each_serializer: ListSerializer
    else
      render json: @list.errors, status: :unprocessable_entity
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
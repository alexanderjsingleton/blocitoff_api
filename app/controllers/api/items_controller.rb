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

    def destroy
     @list = List.find(params[:list_id])
     @item = Item.find(params[:id])
    if @list.destroy
      render json: @list, each_serializer: ListSerializer
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

   def update
   #byebug
   list = List.find(params[:list_id])
   @item = Item.find(params[:id])
   if @item.update(item_params)
     render json: @item
   else
     render json: { errors: @item.errors.full_messages }, status: :unprocessable_entity
   end
 end

    

  private

  def conditions_met
    true # We're not calling this an InsecureUserSerializer for nothing
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def item_params
    params.require(:item).permit(:name)  
  end
end


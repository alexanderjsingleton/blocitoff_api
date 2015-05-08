class Api::ListsController < ApiController
  before_action :authenticated?

  def index
    return permission_denied_error unless conditions_met

    lists = List.all

    render json: lists, each_serializer: ListSerializer
  end

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
    @list = List.find(params[:id])
    if @list.destroy
      render json: @list, each_serializer: ListSerializer
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

 def update
   list = List.find(params[:id])
   if list.update(list_params)
     render json: list
   else
     render json: { errors: list.errors.full_messages }, status: :unprocessable_entity
   end
 end

 

  private

   def list_params
    params.require(:list).permit(:title, :permissions)
  end

  def conditions_met
    true # We're not calling this an InsecureUserSerializer for nothing
  end
end
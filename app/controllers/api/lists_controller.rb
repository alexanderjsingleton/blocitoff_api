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
    @list = current_user.lists.build(list_params)
    title = @list.title

    if @list.destroy
      flash[:list] = "List was removed."
      redirect_to root_path
    else
      flash[:error] = "Item couldn't be deleted.  Please try again."
      redirect_to root_path
    end

    # respond_to do |format|
    #   format.html
    #   fotmat.js
    # end
      
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end

  end

 

  private

   def list_params
    params.require(:list).permit(:title)
  end

  def conditions_met
    true # We're not calling this an InsecureUserSerializer for nothing
  end
end
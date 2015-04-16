class Api::ListsController < ApiController
  def index
    return permission_denied_error unless conditions_met

    lists = List.all

    render json: lists, each_serializer: ListSerializer
  end

  private

  def conditions_met
    true # We're not calling this an InsecureUserSerializer for nothing
  end
end
class Api::ListsController < ApiController
  before_action :authenticated?

  def index
    return permission_denied_error unless conditions_met

    lists = List.all

    render json: lists, each_serializer: ListSerializer
  end

  def create
  end

  private

  def conditions_met
    true # We're not calling this an InsecureUserSerializer for nothing
  end
end
class Api::ItemsController < ApiController
  def index
    return permission_denied_error unless conditions_met

    items = Item.all

    render json: items, each_serializer: ItemSerializer
  end

  private

  def conditions_met
    true # We're not calling this an InsecureUserSerializer for nothing
  end
end
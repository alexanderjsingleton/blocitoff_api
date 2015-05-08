class ListSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :permissions, :user_id, :created_at, :updated_at

  
end

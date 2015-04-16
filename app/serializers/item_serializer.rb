class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :list_id, :created_at, :updated_at
end


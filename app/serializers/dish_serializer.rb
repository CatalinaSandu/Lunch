class DishSerializer < ActiveModel::Serializer
  attributes :id, :dish_title, :dish_type, :picture_url
  has_one :menu
end

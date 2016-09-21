class DishSerializer < ActiveModel::Serializer
  attributes :id, :dish_title, :dish_type
  has_one :menu
end

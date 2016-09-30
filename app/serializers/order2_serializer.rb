class Order2Serializer < ActiveModel::Serializer
  attributes :dish1_title, :dish2_title, :dessert_title
  has_one :user
end

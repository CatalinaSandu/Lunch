class OrderSerializer < ActiveModel::Serializer
  attributes :id, :order_status, :rating, :dish1_id, :dish2_id, :dessert_id
  has_one :menu
end

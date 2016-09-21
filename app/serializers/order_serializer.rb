class OrderSerializer < ActiveModel::Serializer
  attributes :id, :order_status, :user
  has_one :menu
end

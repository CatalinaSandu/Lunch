class MenuSerializer < ActiveModel::Serializer
  attributes :id, :title, :date, :menu_status
  has_one :restaurant
  has_many :dishes
end

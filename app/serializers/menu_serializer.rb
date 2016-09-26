class MenuSerializer < ActiveModel::Serializer
  attributes :id, :title, :date
  has_one :restaurant
  has_many :dishes
end

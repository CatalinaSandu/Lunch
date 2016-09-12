class MenuSerializer < ActiveModel::Serializer

  attributes :id, :date, :title, :first_dish, :second_dish, :dessert
end

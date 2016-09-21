class Dish < ActiveRecord::Base
  belongs_to :menu
  enum dish_type: [:First, :Second, :Dessert]
end

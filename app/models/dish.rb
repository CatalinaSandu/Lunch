class Dish < ActiveRecord::Base
  belongs_to :menu
  enum dish_type: [:First, :Second, :Dessert]

   has_attached_file :picture, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing1.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
end

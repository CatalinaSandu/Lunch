class Order < ActiveRecord::Base
  belongs_to :menu
  has_many :dishes, through: :menu
end

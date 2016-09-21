class AddDishToOrder < ActiveRecord::Migration
  def change
    add_reference :orders, :dish, index: true, foreign_key: true
  end
end

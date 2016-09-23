class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :order_status
      t.integer :rating
      t.integer :dish1_id
      t.integer :dish2_id
      t.integer :dessert_id
      t.references :menu, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

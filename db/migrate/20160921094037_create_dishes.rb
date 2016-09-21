class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.string :dish_title
      t.integer :dish_type
      t.references :menu, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

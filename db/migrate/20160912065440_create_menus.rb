class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.date :date
      t.string :title
      t.string :first_dish
      t.string :second_dish
      t.string :dessert

      t.timestamps null: false
    end
  end
end

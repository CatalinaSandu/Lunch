class AddStatusToMenu < ActiveRecord::Migration
  def change
    add_column :menus, :menu_status, :string
  end
end

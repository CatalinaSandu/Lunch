class AddPictureToDish < ActiveRecord::Migration
   def self.up
    change_table :dishes do |t|
      t.attachment :picture
    end
  end

  def self.down
    drop_attached_file :dishes, :picture
  end
end

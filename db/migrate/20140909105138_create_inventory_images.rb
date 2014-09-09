class CreateInventoryImages < ActiveRecord::Migration
  def change
    create_table :inventory_images do |t|
      t.integer :inventory_id
      t.string :title
      t.string :description
      
      t.timestamps
    end
  end
end

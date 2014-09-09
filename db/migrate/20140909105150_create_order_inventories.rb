class CreateOrderInventories < ActiveRecord::Migration
  def change
    create_table :order_inventories do |t|
      t.integer :order_id
      t.integer :inventory_id
      t.integer :amount
      
      t.timestamps
    end
  end
end

class CreateCartInventories < ActiveRecord::Migration
  def change
    create_table :cart_inventories do |t|
      t.integer :cart_id
      t.integer :inventory_id
      t.integer :amount

      t.timestamps
    end
  end
end

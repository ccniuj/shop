class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.integer :product_id
      t.string :color
      t.string :size
      t.integer :amount
      t.integer :price
      t.integer :popularity

      t.timestamps
    end
  end
end

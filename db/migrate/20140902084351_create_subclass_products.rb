class CreateSubclassProducts < ActiveRecord::Migration
  def change
    create_table :subclass_products do |t|
      t.integer :subclass_id
      t.integer :product_id

      t.timestamps
    end
  end
end

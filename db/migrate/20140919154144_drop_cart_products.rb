class DropCartProducts < ActiveRecord::Migration
  def change
    drop_table :cart_products
  end
end

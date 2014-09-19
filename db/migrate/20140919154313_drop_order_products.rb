class DropOrderProducts < ActiveRecord::Migration
  def change
    drop_table :order_products
  end
end

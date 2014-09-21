class RemovePriceFromInventories < ActiveRecord::Migration
  def change
    remove_column :inventories, :price, :integer
  end
end

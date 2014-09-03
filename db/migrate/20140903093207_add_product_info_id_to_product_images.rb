class AddProductInfoIdToProductImages < ActiveRecord::Migration
  def change
    add_column :product_images, :product_info_id, :integer
  end
end

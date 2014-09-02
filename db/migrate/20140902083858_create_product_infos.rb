class CreateProductInfos < ActiveRecord::Migration
  def change
    create_table :product_infos do |t|
      t.string :style
      t.string :size
      t.integer :amount
      t.integer :price

      t.timestamps
    end
  end
end

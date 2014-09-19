class DropProductInfos < ActiveRecord::Migration
  def change
  	drop_table :product_infos
  end
end

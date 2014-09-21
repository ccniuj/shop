class AddTotalAmountToProducts < ActiveRecord::Migration
  def change
    add_column :products, :total_amout, :integer
  end
end

class AddTotalPopularityToProducts < ActiveRecord::Migration
  def change
    add_column :products, :total_popularity, :integer
  end
end

class SetDefaultInIventoryImages < ActiveRecord::Migration
  def up
  	change_column_default :products, :total_amout, default: 0
  	change_column_default :products, :total_popularity, default: 0
  end

  def down
  	raise ActiveRecord::IrreversibleMigration, "Can't remove the default"
  end
end

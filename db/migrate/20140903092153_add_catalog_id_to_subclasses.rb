class AddCatalogIdToSubclasses < ActiveRecord::Migration
  def change
    add_column :subclasses, :catalog_id, :integer
  end
end

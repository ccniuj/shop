class CreateSubclasses < ActiveRecord::Migration
  def change
    create_table :subclasses do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end

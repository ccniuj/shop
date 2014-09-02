class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.text :size_note
      t.text :attention

      t.timestamps
    end
  end
end

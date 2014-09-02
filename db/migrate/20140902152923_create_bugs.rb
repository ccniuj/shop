class CreateBugs < ActiveRecord::Migration
  def change
    create_table :bugs do |t|
      t.string :name
      t.string :email
      t.string :title
      t.text :content
      t.integer :status
      t.timestamps
    end
  end
end

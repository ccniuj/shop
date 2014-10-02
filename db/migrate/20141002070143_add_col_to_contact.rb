class AddColToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :string, :email
  end
end

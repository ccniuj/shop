class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.integer :user_id
      t.string :receive_address
      t.string :invoice_address
      t.timestamps
    end
  end
end

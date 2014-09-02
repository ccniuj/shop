class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :contact_id
      t.integer :pay_method
      t.integer :ship_method
      t.integer :status
      t.integer :total_price
      t.timestamps
    end
  end
end

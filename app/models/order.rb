class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_inventories, dependent: :destroy
  has_many :items, :through => :order_inventories, :source => :inventory, dependent: :destroy

  def add!(inventory, amount)
    items << inventory
    items << amount
  end
  
end

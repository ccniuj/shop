class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_inventories, dependent: :destroy
  has_many :items, :through => :order_inventories, :source => :inventory, dependent: :destroy
  validates :contact_id, :presence => true
  validates :pay_method, :presence => true
  validates :ship_method, :presence => true
  validates :status, :presence => true
  validates :total_price, :presence => true

  def add!(inventory, amount)
    items << inventory
    items << amount
  end
  
end

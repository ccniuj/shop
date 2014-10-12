class Inventory < ActiveRecord::Base
  belongs_to :product
  has_many :inventory_images, dependent: :destroy
  has_many :cart_inventories, dependent: :destroy
  has_many :items, :through => :cart_inventories, :source => :cart, dependent: :destroy
  has_many :order_inventories, dependent: :destroy
  has_many :items, :through => :order_inventories, :source => :order, dependent: :destroy

  validates_presence_of :color, :size
  validates :amount, presence: true, numericality: true
end

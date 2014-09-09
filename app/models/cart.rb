class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :cart_inventories, dependent: :destroy
  has_many :items, :through => :cart_inventories, :source => :inventory, dependent: :destroy

  def remove!(inventory)
    items.delete(inventory)
  end
  
end

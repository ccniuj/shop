class CartInventory < ActiveRecord::Base
  belongs_to :cart
  belongs_to :inventory
end

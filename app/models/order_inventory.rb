class OrderInventory < ActiveRecord::Base
  belongs_to :order
  belongs_to :inventory
end

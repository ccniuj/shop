class InventoryImage < ActiveRecord::Base
  belongs_to :inventory
  validates_presence_of :title, :description
end

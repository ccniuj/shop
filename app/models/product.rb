class Product < ActiveRecord::Base
  has_many :inventories
  has_many :belonged_subclass, :through => :subclass_products, :source => :subclass
end

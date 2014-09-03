class Product < ActiveRecord::Base
  has_many :product_infos
  has_many :belonged_subclass, :through => :subclass_products, :source => :subclass
  has_many :cart_products
  has_many :items, :through => :cart_products, :source => :cart
end

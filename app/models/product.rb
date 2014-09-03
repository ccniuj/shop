class Product < ActiveRecord::Base

  has_many :belonged_subclass, :through => :subclass_products, :source => :subclass
  has_many :product_infos

end

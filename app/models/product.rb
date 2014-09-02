class Product < ActiveRecord::Base

  has_many :subclass_products
  has_many :product_infos

end

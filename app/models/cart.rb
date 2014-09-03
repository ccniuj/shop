class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :items, :through => :cart_products, :source => :product
end

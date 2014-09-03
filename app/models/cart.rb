class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :cart_products
  has_many :items, :through => :cart_products, :source => :product

  def remove!(product)
    items.delete(product)
  end
  def foo
  end
end

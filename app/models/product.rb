class Product < ActiveRecord::Base
  has_many :inventories
  has_many :subclass_products
  has_many :belonged_subclasses, :through => :subclass_products, :source => :subclass

  scope :has_invt, -> { where("total_amout > total_popularity") }
  scope :r_new, -> { order("created_at DESC") }
  scope :r_hot, -> { order("total_popularity DESC") }
end

class Product < ActiveRecord::Base
  has_many :inventories, dependent: :destroy
  has_many :subclass_products, dependent: :destroy
  has_many :belonged_subclasses, :through => :subclass_products, :source => :subclass

  validates_presence_of :name, :description, :size_note, :attention
  validates :price, presence: true, numericality: true

  scope :has_invt, -> { where("total_amout > total_popularity") }
  scope :r_new, -> { order("created_at DESC") }
  scope :r_hot, -> { order("total_popularity DESC") }
end

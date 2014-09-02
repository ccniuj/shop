class Subclass < ActiveRecord::Base

  belongs_to :catalog
  has_many :subclass_products

end

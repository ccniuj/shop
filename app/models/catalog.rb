class Catalog < ActiveRecord::Base
  has_many :subclasses, dependent: :destroy
  
  validates_presence_of :name, :description
end

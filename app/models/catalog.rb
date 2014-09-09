class Catalog < ActiveRecord::Base
  has_many :subclasses, dependent: :destroy
end

class SubclassProduct < ActiveRecord::Base

  belongs_to :subclass
  belongs_to :product

end

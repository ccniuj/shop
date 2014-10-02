class Contact < ActiveRecord::Base
  belongs_to :user
  validates :name, :presence => true
  validates :cellphone, :presence => true
  validates :address, :presence => true
  validates :email, :presence => true
end

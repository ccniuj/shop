class User < ActiveRecord::Base

  include Authority::UserAbilities
  include Authority::Abilities

  has_many :orders
  has_many :carts
  has_many :contacts
  has_many :coupons
  has_many :member_questions
  has_many :answers
  has_and_belongs_to_many :roles, :through => :users_roles, :source => :role

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
end

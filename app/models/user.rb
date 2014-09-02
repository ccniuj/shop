class User < ActiveRecord::Base
  has_many :orders
  has_many :carts
  has_many :contacts
  has_many :coupons
  has_many :member_questions
  has_many :answers

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end

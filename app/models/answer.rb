class Answer < ActiveRecord::Base
  belongs_to :member_question
  belongs_to :user
  validates :content, :presence => true
end

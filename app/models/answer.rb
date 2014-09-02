class Answer < ActiveRecord::Base
  belongs_to :member_question
  belongs_to :user
end

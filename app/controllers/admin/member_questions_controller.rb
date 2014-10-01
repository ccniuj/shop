class Admin::MemberQuestionsController < ApplicationController
  before_action :authenticate_user!
  # authorize_actions_for User
  
  def index
    @mqs = MemberQuestion.all.order("status ASC, created_at DESC")
  end

  def show
    @mqs = User.find(params[:id]).member_questions.all
    @answer = Answer.new
  end

end

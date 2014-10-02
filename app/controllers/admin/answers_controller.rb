class Admin::AnswersController < ApplicationController
  
  def create
    @mq = MemberQuestion.find(params[:member_question_id])
    @answer = @mq.answers.new(answer_params)
    
    update_status
    if @answer.save!
      redirect_to admin_member_question_path(@mq.user), :notice => "成功新增回覆"
    else
      render :show
    end
  end
  
  def update_status
    @mq.update(status: params[:member_question][:status])
  end

  private
  
  def answer_params
    params[:answer][:user_id] = current_user.id
    params.require(:answer).permit(:user_id, :content)
  end
end

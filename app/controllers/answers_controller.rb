class AnswersController < ApplicationController

  def create
    @mq = MemberQuestion.find(params[:member_question_id])
    @answer = @mq.answers.new(answer_params)
    if @answer.save!
      redirect_to member_question_path(@mq), :notice => "Answer is updated succesfully."
    else
      render :show
    end
  end

  private

  def answer_params
    params[:answer][:user_id] = current_user.id
    params.require(:answer).permit(:user_id, :content)
  end

end

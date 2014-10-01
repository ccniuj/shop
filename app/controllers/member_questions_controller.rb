class MemberQuestionsController < ApplicationController
  before_action :authenticate_user!

  def index 
    @mqs = current_user.member_questions.all
  end

  def show 
    @mq = current_user.member_questions.find(params[:id])
    @answer = Answer.new
  end
  
  def new 
    @mq = current_user.member_questions.new
  end
  
  def edit
    @mq = current_user.member_questions.find(params[:id])
  end

  def create
    @mq = current_user.member_questions.new(mq_params)
    if @mq.save!
      redirect_to member_questions_path, :notice => "Question is created succesfully."
    else
      render :new
    end
  end
  
  def update 
    @mq = current_user.member_questions.find(params[:id])
    if @mq.update(mq_params)
      redirect_to member_questions_path, :notice => "Question is updated succesfully."
    else
      render :edit
    end
  end

  def destroy
    @mq = current_user.member_questions.find(params[:id])
    @mq.destroy
    redirect_to member_questions_path, :alert => "Question is deletted succesfully."
  end

  private 

  def mq_params()
    params[:member_question][:status] = "1"
    params.require(:member_question).permit(:title, :content, :status)
  end
end

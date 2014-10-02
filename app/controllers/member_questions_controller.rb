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
    if @mq.save
      redirect_to member_questions_path, :notice => "成功新增提問"
    else
      flash[:alert] = "必須輸入標題、內容"
      render :new
    end
  end
  
  def update 
    @mq = current_user.member_questions.find(params[:id])
    if @mq.update(mq_params)
      redirect_to member_questions_path, :notice => "成功更新提問"
    else
      flash[:alert] = "必須輸入標題、內容"
      render :edit
    end
  end

  def destroy
    @mq = current_user.member_questions.find(params[:id])
    @mq.destroy
    redirect_to member_questions_path, :alert => "成功刪除提問"
  end

  private 

  def mq_params()
    params[:member_question][:status] = "1"
    params.require(:member_question).permit(:title, :content, :status)
  end
end

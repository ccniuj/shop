class Admin::FaqsController < ApplicationController
  before_action :authenticate_user!
  # authorize_actions_for User

  def index
    @faqs = Faq.all
  end

  def show 
    @faq = Faq.find(params[:id])
  end

  def new 
    @faq = Faq.new
  end

  def edit 
    @faq = Faq.find(params[:id])
  end

  def create 
    @faq = Faq.new(faq_params)
    if @faq.save!
      redirect_to admin_faqs_path, :notice => "成功新增常見問題"
    else
      render :new
    end
  end

  def update 
    @faq = Faq.find(params[:id])
    if @faq.update(faq_params)
      redirect_to admin_faqs_path, :notice => "成功更新常見問題"
    else
      render :edit
    end
  end
  
  def destroy
    @faq = Faq.find(params[:id])
    @faq.destroy
    redirect_to admin_faqs_path, :alert => "成功刪除常見問題"
  end
  private

  def faq_params
    params.require(:faq).permit(:question, :answer)
  end
end

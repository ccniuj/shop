class Admin::BugsController < ApplicationController
  before_action :authenticate_user!
  # authorize_actions_for User

  def index
    @bugs = Bug.all
  end

  def show 
    @bug = Bug.find(params[:id])
  end

  def update 
    @bug = Bug.find(params[:id])
    if @bug.update(bug_params)
      redirect_to admin_bugs_path, :notice => "成功更新錯誤回報"
    else
      render :show
    end
  end

  private

  def bug_params
    params.require(:bug).permit(:status)
  end
end

class Admin::UsersController < ApplicationController

  before_action :authenticate_user!
  authorize_actions_for User

  def index
    @users = []
    User.all.each do | user |
      unless user.has_role?(:admin) || user.has_role?(:service) || user.has_role?(:shopper) || user.has_role?(:analyst)
        @users << user
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    authorize_action_for @user
    @user.destroy

    redirect_to admin_roles_path , :alert => "已成功刪除此位使用者"
  end

  private

end

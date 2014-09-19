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

  def change
    @user = User.find(params[:user_id])
    authorize_action_for @user
    @all_roles = [ :admin, :service, :shopper, :analyst ]
    
    @user_new_roles = []
    if params[:roles]
      params[:roles].each do | role |
        @user_new_roles << role.to_sym
      end
    end

    has_change = false
    remove_last_one = false
    last_one_role = ""

    @all_roles.each do | role |
      if !(is_last_one?(role))
        if (!(@user.has_role?(role)) && @user_new_roles.include?(role))
          @user.add_role role
          has_change = true
        elsif (@user.has_role?(role) && !(@user_new_roles.include?(role)))
          @user.remove_role role
          has_change = true
        end
      else
        if (!(@user.has_role?(role)) && @user_new_roles.include?(role))
          @user.add_role role
          has_change = true
        elsif (@user.has_role?(role) && !(@user_new_roles.include?(role)))
          remove_last_one = true
          last_one_role = role.to_s
        end
      end
    end

    if remove_last_one
      flash[:alert] = "至少要有一位管理人員擁有 "+last_one_role+" 權限，其餘權限變更以完成"
    else
      has_change ? flash[:notice] = "已成功變更此位使用者的權限" : flash[:alert] = "你並未進行任何變更"
    end

    redirect_to admin_roles_path

  end
  
  private

  def is_last_one?(role)
    if User.all.with_any_role(role).count < 2
      return true
    else
      return false
    end
  end

end

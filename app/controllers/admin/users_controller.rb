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
    @user_old_roles = []
    last_one_roles = []

    params[:old_roles].each { | role | @user_old_roles << role.to_sym } if params[:old_roles]

    @user_old_roles.each do | old_role |
      if is_last_one?(old_role)
        last_one_roles << old_role.to_s
      end
    end

    unless last_one_roles[0]
      @user.destroy
      flash[:notice] = "已成功刪除此位使用者"
    else
      last_one_roles_for_put = ""
      last_one_roles.each do | role | 
        last_one_roles_for_put.insert( -1, role+" " )
      end
      flash[:alert] = "無法刪除，至少要有一位管理人員擁有 " + last_one_roles_for_put + "權限"
    end

    redirect_to admin_roles_path
  end

  def change
    @user = User.find(params[:user_id])
    authorize_action_for @user
    @all_roles = [ :admin, :service, :shopper, :analyst ]
    has_change = false
    remove_last_one = false
    last_one_roles_for_put = ""
    @user_new_roles = []
    @user_old_roles = []
    
    params[:roles].each { | role | @user_new_roles << role.to_sym } if params[:roles]

    params[:old_roles].each { | role | @user_old_roles << role.to_sym } if params[:old_roles]

    @user_old_roles.each do | old_role |
      unless @user_new_roles.include?(old_role)
        unless is_last_one?(old_role)
          @user.remove_role old_role
          has_change = true
        else
          remove_last_one = true
          last_one_roles_for_put.insert( -1, old_role.to_s+" " ) 
        end
      end
    end

    @user_new_roles.each do | new_role |
      unless @user_old_roles.include?(new_role)
        @user.add_role new_role
        has_change = true
      end
    end

    # @all_roles.each do | role |
    #   if !(is_last_one?(role))
    #     if (!(@user.has_role?(role)) && @user_new_roles.include?(role))
    #       @user.add_role role
    #       has_change = true
    #     elsif (@user.has_role?(role) && !(@user_new_roles.include?(role)))
    #       @user.remove_role role
    #       has_change = true
    #     end
    #   else
    #     if (!(@user.has_role?(role)) && @user_new_roles.include?(role))
    #       @user.add_role role
    #       has_change = true
    #     elsif (@user.has_role?(role) && !(@user_new_roles.include?(role)))
    #       remove_last_one = true
    #       last_one_roles_for_put = role.to_s
    #     end
    #   end
    # end

    if remove_last_one
      flash[:alert] = "至少要有一位管理人員擁有 "+last_one_roles_for_put+"權限，其餘權限變更以完成"
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
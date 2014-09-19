class Admin::RolesController < ApplicationController
  
  before_action :authenticate_user!
  # authorize_actions_for Role

  def index
    @users = User.with_any_role(:admin, :service, :shopper, :analyst)
    @roles = Role.all
  	# @role = User.find(params[:id]).role_of?

  	  # def role_of?(user)
     #    @user_id = user.id
     #    @role_id = UsersRoles.where("user_id = @user_id").role_id
     #    @role = Role.find(@role_id).name

     #    return @role
      # end
  end

end

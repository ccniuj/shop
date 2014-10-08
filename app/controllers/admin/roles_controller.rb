class Admin::RolesController < ApplicationController
  
  before_action :authenticate_user!
  authorize_actions_for Role

  def index
    @users = User.with_any_role(:admin, :service, :shopper, :analyst)
    @roles = Role.all
  end

end

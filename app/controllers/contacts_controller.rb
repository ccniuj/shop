class ContactsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @contact = current_user.contacts.new
  end

  def show
    @contact = current_user.contacts.find(params[:id])
  end

  def edit
    @contact = current_user.contacts.find(params[:id])
  end
end

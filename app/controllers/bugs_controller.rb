class BugsController < ApplicationController
  def new
    @bug = Bug.new
  end

  def create 
    @bug = Bug.new(bug_params)
    if @bug.save!
      redirect_to root_path, :notice => "Report is created succesfully."
    else
      render :new
    end
  end

  private

  def bug_params
    params[:bug][:status] = "1"
    params.require(:bug).permit(:name, :email, :title, :content, :status)
  end
end

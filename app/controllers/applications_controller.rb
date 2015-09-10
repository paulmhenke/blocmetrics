class ApplicationsController < ApplicationController
    
  def index
    @user = current_user
    @user_applications = @user.applications
  end
  
  def new
    @user = current_user
    @application = Application.new
  end
end

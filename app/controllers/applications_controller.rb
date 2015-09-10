class ApplicationsController < ApplicationController
    
  def index
    @user = current_user
    @applications = @user.applications
  end
  
  def new
    @user = current_user
    @application = Application.new
  end
  
  def create
    @application = Application.new(application_params)
    @application.user = current_user
    
    if @application.save
      flash[:notice] = "Your application has been added to your account."
      redirect_to applications_path
    else
      flash[:error] = "There was an error saving your application. Please try again."
      redirect_to new_application_path
    end
  end
  
  
  private
  
  def application_params
    params.require(:application).permit(:url)
end

class RegApplicationsController < ApplicationController
    
  def index
    @user = current_user
    @applications = @user.reg_applications
  end
  
  def new
    @user = current_user
    @application = RegApplication.new
  end
  
  def create
    @application = RegApplication.new(application_params)
    @application.user = current_user
    
    if @application.save
      flash[:notice] = "Your application has been added to your account."
      redirect_to reg_applications_path
    else
      flash[:error] = "There was an error saving your application. Please try again."
      redirect_to new_reg_application_path
    end
  end
  
  def show 
    @user = current_user
    @application = RegApplication.find(params[:id])
    @events = @application.events.group_by(&:name)
  end
  
  def destroy
    @application = RegApplication.find(params[:id])
    if @application.destroy
      flash[:notice] = "This Site has been removed from monitoring"
      redirect_to reg_applications_path
    else
      flash[:error] = "There was an error. Please try again."
      redirect_to [@application] #? is this right
    end
  end
  
  
  private
  
  def application_params
    params.require(:reg_application).permit(:url, :name)
  end
end

class ServicesController < ApplicationController
  # before_action :require_admin
  # load_and_authorize_resource


  def index
    @services = Service.all
  end
  def show
    @service = Service.find(params[:id])
  end
  def new
    @service = Service.new
  end

  def create
   @service =Service.new(service_params)
   @service.user = current_user
    if@service.save
      redirect_to services_path
    else
      render :new
    end
  end

  def edit
    @service = Service.find(params[:id])
  end

  def update
   @service = current_user.services.find_by_id(params[:id])
    if @service.present?
      @service.update(service_params)
      redirect_to services_path
    else
      # render :edit
      flash[:notice]= "you con't update another Admins service.ss"
      redirect_to services_path
    end
  end

  def destroy
    @service = current_user.services.find_by_id(params[:id])
    if @service.present?
      @service.delete
      redirect_to services_path
    else
      flash[:notice]="you con't delete another Admin service."
      redirect_to services_path
    end
  end

  private

  def service_params
    params.require(:service).permit(:service_name, :status ,:location, :city, :user_id,:service_profile)
  end
end


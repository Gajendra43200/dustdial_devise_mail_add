class ReviewsController < ApplicationController
  # load_and_authorize_resource
def index
    @reviews= Review.all
  end
  def new
    if params[:service_id]
      @service = Service.find(params[:service_id])
      @review = @service.reviews.new
    else
      @services = Service.all
    end
    @review = Review.new
  end

   def show
    @review = Review.find(params[:id])
  end

  def create
    @service = Service.find(params[:review][:service_id])
    @review = @service.reviews.new(review_params)
    @review.user = current_user
    if @review.save
     redirect_to reviews_path,notice: "Review Creted successfully."
    else
     render :new
    end
  end

  def edit
    @review = Review.find(params[:id])
  end
  def update
    @review = current_user.reviews.find_by_id(params[:id])

    if @review.present?
      @review.update(review_params)
      redirect_to reviews_path
    else
      redirect_to reviews_path, notice: "you con't update another users's review."
    end
  end

  def destroy
    @review = current_user.reviews.find_by_id(params[:id])
    if @review.present?
      @review.delete
      redirect_to reviews_path, notice: "Review deleted successfully."
    else
      redirect_to reviews_path, notice: "you con't delete another users's review."
    end
  end

  def location_service_name
    if  params[:service_name].present?
      @services = Service.where("service_name like ?" ,"%#{params[:service_name]}%")
      if @services.present?
      render 'service_name_print'
    else
      redirect_to reviews_path, notice: "Service Not Exits "
    end
    elsif params[:city].present?
      @services = Service.where("city like ?" ,"%#{params[:city]}%")
       if @services.present?
        render 'reviews/service_name_print'
      else
        redirect_to reviews_path ,notice: "Service Not Exits For This City"
      end

      elsif params[:status].present?
      @services = Service.where("status like ?" ,"%#{params[:status]}%")
       if @services.present?
        render 'reviews/service_name_print'
      else
        redirect_to reviews_path ,notice: "Service Not Exits For This status"
      end
    elsif params[:avg_rating].present?
      @services = Service.where("avg_rating like ?" ,"%#{params[:avg_rating]}%")
       if @services.present?
        render 'reviews/service_name_print'
      else
        @services = Service.order(avg_rating: :desc)
        render 'reviews/service_name_print'
      end

    elsif current_user.present?
      @services = Service.where(location: current_user.location)
      if @services.present?
        render 'service_name_print'
      else
        services = Service.all
        redirect_to services_path
      end
  end
end
  private
  def review_params
    params.require(:review).permit(:content, :rating, :service_id)

  end
end


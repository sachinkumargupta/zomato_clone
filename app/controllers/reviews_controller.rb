class ReviewsController < ApplicationController
  before_action :find_restaurant
  before_action :logged_in_user
  before_action :correct_user_or_admin, only: [:destroy, :update]

  def show
    @review = Review.find(params[:id])
  end
  
  def edit
    @review = Review.find(params[:id])
  end

  def create
    @review = @restaurant.reviews.new(review_params)
    @review.user_id = current_user.id
    if current_user.admin?
      @review.approved = true
      flash[:info] = "Review added successfully!!"
    end
    if @review.save
      flash[:info] = "Thanks for your Review. It will be shown after being approved by the Admin" unless current_user.admin?
    else
      flash[:danger] = "Failed to add the Review. Rating must be present"
    end
    redirect_to restaurant_path(@restaurant)
  end

  def approved
    @review = @restaurant.reviews.find(params[:review_id])
    @review.update(approved: true)
    redirect_to @restaurant
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      flash[:success] = "Review updated successfully"
      redirect_to @restaurant
    else
      render :edit
    end
  end

  def destroy
   @review.destroy
   redirect_to restaurant_path(@restaurant)
  end

  private
    def review_params
      params.require(:review).permit(:rating, :comment, :category, :photo)
    end

    def find_restaurant
      @restaurant = Restaurant.find(params[:restaurant_id])
    end

    def correct_user_or_admin
      @review = @restaurant.reviews.find(params[:id])
      unless current_user.id == @review.user_id || current_user.admin?
        flash[:danger] = "Access Denied"
        redirect_to restaurant_path(@restaurant)
      end
    end
end

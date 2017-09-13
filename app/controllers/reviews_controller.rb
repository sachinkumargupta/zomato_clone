class ReviewsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user_or_admin, only: :destroy

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.new(review_params)
    @review.user_id = current_user.id
    if current_user.admin?
      @review.approved = true
    end
    @review.save
    redirect_to restaurant_path(@restaurant)
  end

 def destroy
   @review.destroy
   redirect_to restaurant_path(@restaurant)
 end

  private
    def review_params
      params.require(:review).permit(:rating, :comment)
    end

    def correct_user_or_admin
      @restaurant = Restaurant.find(params[:restaurant_id])
      @review = @restaurant.reviews.find(params[:id])
      unless current_user.id == @review.user_id || current_user.admin?
        flash[:danger] = "Access Denied"
        redirect_to restaurant_path(@restaurant)
      end
    end
end

class ImagesController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user_or_admin, only: :destroy

  def show
    @image = Image.find_by(params[:image_id])
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @image = @restaurant.images.create(image_params)
    redirect_to restaurant_path(@restaurant)
  end

  def destroy
    @restaurant = Restaurant.find(params[:restaurant_id])
    @image = @restaurant.images.find(params[:id])
    @image.destroy
    redirect_to restaurant_path(@restaurant)
  end
 
  private
    def image_params
      params.require(:image).permit(:category, :photo)
    end

    def correct_user_or_admin
      @restaurant = Restaurant.find(params[:restaurant_id])
      @image = @restaurant.images.find(params[:id])
      unless current_user.id == @image.user_id || current_user.admin?
        flash[:danger] = "Access Denied"
        redirect_to restaurant_path(@restaurant)
      end
    end
end
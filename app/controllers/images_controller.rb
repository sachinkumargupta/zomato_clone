class ImagesController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user_or_admin, only: :destroy

  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @image = Image.find_by(restaurant_id: @restaurant.id)
  end

  def show
    @image = Image.find_by(params[:image_id])
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @image = @restaurant.images.create(image_params)
    flash[:success] = "Image Uploaded successfully"
    redirect_to restaurant_images_path(@restaurant)
  end

  def destroy
    @restaurant = Restaurant.find(params[:restaurant_id])
    @image = @restaurant.images.find(params[:id])
    @image.destroy
    flash[:success] = "Image destroyed successfully"
    redirect_to restaurant_images_path(@restaurant)
  end
 
  private
    def image_params
      params.require(:image).permit(:category, :photo)
    end

    def correct_user_or_admin
      @restaurant = Restaurant.find(params[:restaurant_id])
      @image = @restaurant.images.find(params[:id])
      unless current_user.admin?
        flash[:danger] = "Access Denied"
        redirect_to restaurant_path(@restaurant)
      end
    end
end

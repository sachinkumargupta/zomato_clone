class ImagesController < ApplicationController
  before_action :logged_in_user
  before_action :find_restaurant
  before_action :correct_user_or_admin, only: :destroy

  def index
    @images = @restaurant.images
  end

  def create
    @image = @restaurant.images.create(image_params)
    flash[:success] = "Image Uploaded successfully"
    redirect_to restaurant_images_path(@restaurant)
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    flash[:success] = "Image destroyed successfully"
    redirect_to restaurant_images_path(@restaurant)
  end
 
  private
    def image_params
      params.require(:image).permit(:category, :photo)
    end

    def find_restaurant
      @restaurant = Restaurant.find(params[:restaurant_id])
    end

    def correct_user_or_admin
      @image = @restaurant.images.find(params[:id])
      unless current_user.admin?
        flash[:danger] = "Access Denied"
        redirect_to restaurant_path(@restaurant)
      end
    end
end

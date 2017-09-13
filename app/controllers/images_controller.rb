class ImagesController < ApplicationController
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
end

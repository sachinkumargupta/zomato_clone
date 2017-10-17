class ImagesController < ApplicationController
  before_action :logged_in_user

  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @reviews = @restaurant.reviews
  end
 end

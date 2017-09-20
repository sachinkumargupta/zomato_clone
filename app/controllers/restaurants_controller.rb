class RestaurantsController < ApplicationController
  before_action :logged_in_user, except: [:index, :show, :location]
  before_action :admin_user,     except: [:index, :show, :location]

  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    if logged_in? && current_user.admin?
      @reviews = @restaurant.reviews.order("created_at DESC")
    else
      @reviews = @restaurant.reviews.order("created_at DESC").where(approved: true);
    end
  end

  def new
    @restaurant = Restaurant.new
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
  
    if @restaurant.save
      redirect_to @restaurant, notice: 'Restaurant was successfully created.'
    else
      render :new
    end
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    
    if @restaurant.update(restaurant_params)
      redirect_to @restaurant, notice: 'Restaurant was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    redirect_to restaurants_url, notice: 'Restaurant was successfully destroyed.'    
  end

  def location
    @restaurant = Restaurant.find(params[:id])
  end

  def search
    params[:search].chomp.split(/,\s*/).each do |key|
       @restaurants = Restaurant.where(["name like ? or
                                         address like ? or 
                                         restaurant_type like ?","%#{key}%","%#{key}%","%#{key}%"])
    end

    if @restaurants.count == 0
      flash.now[:info] = 'No Record Found'
    end
    render :index
  end

  private
    def restaurant_params
      params.require(:restaurant).permit(:name, :address, :restaurant_type, :lat, :long, :location_url, :cover_photo )
    end
end
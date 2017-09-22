class RestaurantsController < ApplicationController
  before_action :logged_in_user, except: [:index, :show, :location, :search, :filter, :nearby, :error]
  before_action :admin_user,     except: [:index, :show, :location, :search, :filter, :nearby, :error]

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
    @reviews.joins(:users)
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
      flash[:success] = "Restaurant was successfully created"
      redirect_to @restaurant
    else
      render :new
    end
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    
    if @restaurant.update(restaurant_params)
      flash[:success] = "Restaurant was successfully updated."
      redirect_to @restaurant
    else
      render :edit
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    flash[:success] = "Restaurant was successfully destroyed."
    redirect_to restaurants_url
  end

  def location
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def error
  end

  def filter
    if params[:nearby].present? || params[:type].present?
      if params[:nearby].present?
        @restaurants = Restaurant.near(params[:nearby], 8)
        flash.now[:info] = "No Record Found" if @restaurants && @restaurants.length == 0
        render :index
      elsif params[:type].present?
        params[:type].split(/,\s*/).each do |key|
           @restaurants = Restaurant.where(["restaurant_type like ?","%#{key}%"])
           flash.now[:info] = "No Record Found" if @restaurants && @restaurants.count == 0
           render :index
        end
      end
    else
      redirect_to root_url
    end
  end

  def search
    if params[:search].present?
      params[:search].chomp.split(/,\s*/).each do |key|
         @restaurants = Restaurant.where(["name like ? or
                                           address like ? or 
                                           restaurant_type like ?","%#{key}%","%#{key}%","%#{key}%"])
      end
      if @restaurants && @restaurants.count == 0
        params[:nearby] = params[:search]
        params[:type] = params[:search]
        filter
      else
        render :index
      end
    else
      redirect_to restaurants_url
    end
  end

  private
    def restaurant_params
      params.require(:restaurant).permit(:name, :address, :restaurant_type, :latitude, :longitude, :location_url, :cover_photo )
    end
end
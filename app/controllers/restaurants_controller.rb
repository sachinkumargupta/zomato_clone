class RestaurantsController < ApplicationController
  before_action :find_restaurant, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, except: [:index, :show, :location, :search, :filter, :nearby, :error]
  before_action :admin_user,     except: [:index, :show, :location, :search, :filter, :nearby, :error]

  def index
    @restaurants = Restaurant.all
  end

  def show
    if logged_in? && current_user.admin?
      @reviews = @restaurant.reviews.includes(:user).order("created_at DESC")
    else
      @reviews = @restaurant.reviews.includes(:user).order("created_at DESC").where(approved: true);
    end
  end

  def new
    @restaurant = Restaurant.new
  end

  def edit
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
    if @restaurant.update(restaurant_params)
      flash[:success] = "Restaurant was successfully updated."
      redirect_to @restaurant
    else
      render :edit
    end
  end

  def destroy
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
    count = 0
    begin
      if params[:nearby].present? || params[:type].present?
        if params[:nearby].present?
          @restaurants = Restaurant.near(params[:nearby], 8).order("distance ASC").first(3)
          flash.now[:info] = "No Record Found" if @restaurants && @restaurants.length == 0
          render :index
        elsif params[:type].present?
          params[:type].split(/,\s*/).each do |key|
             @restaurants = Restaurant.filter_based_on_type(key)
             flash.now[:info] = "No Record Found" if @restaurants && @restaurants.count == 0
             render :index
          end
        end
      else
        redirect_to root_url
      end
    rescue
      flash.now[:info] = "Sorry! Something went wrong, Google API did not respond correctly. Please try again after something"
      render :search
    end
  end

  #common search bar
  def search      
    if params[:search].present?
      params[:search].chomp.split(/,\s*/).each do |key|
         @restaurants = Restaurant.search_with_keywords(key)
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

    def find_restaurant
      @restaurant = Restaurant.find(params[:id])  
    end
end
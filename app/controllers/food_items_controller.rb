class FoodItemsController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user

  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @food_items = @restaurant.food_items
  end
  
  def show
    @restaurant = Restaurant.find(params[:restaurant_id])
    @food_item = FoodItem.find(params[:id]) 
  end
  
  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @food_item = FoodItem.new
    @food_items = @restaurant.food_items
  end
  
  def edit
    @restaurant = Restaurant.find(params[:restaurant_id])
    @food_item = FoodItem.find(params[:id])
  end
  
  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @food_item = @restaurant.food_items.new(food_item_params)

    if @food_item.save
      redirect_to restaurant_food_item_path(@restaurant, @food_item), flash.now[:info]
    else
      render :new
    end
  end
  
  def update
    @restaurant = Restaurant.find(params[:restaurant_id])
    @food_item = FoodItem.find(params[:id])
    if @food_item.update(food_item_params)
      redirect_to [@restaurant, @food_item], notice: 'Food Item was updated successfully'
    else
      render :edit
    end
  end
  
  def destroy
    @restaurant = Restaurant.find(params[:restaurant_id])
    @food_item = FoodItem.find(params[:id])
    @food_item.destroy
    redirect_to restaurant_food_items_path(@restaurant)
  end

  private
    def food_item_params
      params.require(:food_item).permit(:name,:price)
    end
end
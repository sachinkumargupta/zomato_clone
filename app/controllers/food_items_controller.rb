class FoodItemsController < ApplicationController
  before_action :logged_in_user
  before_action :find_food, only: [:show, :edit, :update, :destroy]
  before_action :find_restaurant
  before_action :admin_user

  def index
    @food_items = @restaurant.food_items
  end
  
  def show
  end
  
  def new
    @food_item = FoodItem.new
    @food_items = @restaurant.food_items
  end
  
  def edit
  end
  
  def create
    @food_item = @restaurant.food_items.new(food_item_params)

    if @food_item.save
      flash[:success] = "Food Item added successfully"
      redirect_to restaurant_food_item_path(@restaurant, @food_item)
    else
      render :new
    end
  end
  
  def update
    if @food_item.update(food_item_params)
      flash[:success] = "Food Item updated successfully"
      redirect_to [@restaurant, @food_item]
    else
      render :edit
    end
  end
  
  def destroy
    @food_item.destroy
    flash[:success] = "Food Item destroyed successfully"
    redirect_to restaurant_food_items_path(@restaurant)
  end

  private
    def food_item_params
      params.require(:food_item).permit(:name,:price)
    end

    def find_restaurant
      @restaurant = Restaurant.find(params[:restaurant_id])
    end

    def find_food
      @food_item = FoodItem.find(params[:id])
    end
end
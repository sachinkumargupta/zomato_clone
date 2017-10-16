class OrdersController < ApplicationController
  before_action :logged_in_user
  before_action :find_restaurant
  before_action :find_food_items, only: [:new, :edit, :create, :update]
  before_action :find_order, only: [:show, :edit, :update]
  before_action :correct_user_or_admin, only: [:destroy, :show, :edit, :update]

  def index
    if current_user.admin?
      @orders = @restaurant.orders.includes(:user)
    else  
      @orders = @restaurant.orders.includes(:user).where(user_id: current_user.id)
    end
  end
  
  def show
    @name = FoodItem.pluck(:name);
    @quantities = @order.quantity_array.split(' ').map(&:to_i)
    @item_array_id = @order.item_array.split(' ')
    @price = FoodItem.find([@item_array_id]).pluck(:price)
  end
  
  def new
    @order = Order.new
  end
  
  def edit
    if @order.created_at < Date.today
      flash[:warning] = "You can not edit this Order anymore"
      redirect_to restaurant_orders_path(@restaurant)
    end
  end

  def create
    @order = @restaurant.orders.new(order_params)
    @order.user_id = current_user.id
    @order.total = calculate_total(@order.item_array, @order.quantity_array)

    if @order.save
      flash[:success] = "Order Placed successfully"
      redirect_to restaurant_order_path(@restaurant, @order)
    else
      render :new
    end
  end

  def update
    @order.update(order_params)
    @order.total = calculate_total(@order.item_array, @order.quantity_array)
    if @order.save
      flash[:success] = "Order Updated successfully"
      redirect_to restaurant_order_path(@restaurant, @order)
    else
      render :new
    end
  end
  
  def destroy
    @order.destroy
    flash[:success] = "Order destroyed successfully"
    redirect_to restaurant_orders_path(@restaurant)
  end

  private
    def order_params
      params.require(:order).permit(:item_array, :quantity_array, :total ,:delivery_address)
    end

    def find_restaurant
      @restaurant = Restaurant.find(params[:restaurant_id])
    end

    def find_order
      @order = Order.find(params[:id])
    end

    def find_food_items
      @food_items = @restaurant.food_items.all
    end

    def correct_user_or_admin
      @restaurant = Restaurant.find(params[:restaurant_id])
      @order = @restaurant.orders.find(params[:id])
      unless current_user.id == @order.user_id || current_user.admin?
        flash[:danger] = "Access Denied"
        redirect_to restaurant_path(@restaurant)
      end
    end

    def calculate_total(item_array, quantity_array)
      @quantities = quantity_array.split(' ').map(&:to_i)
      @item_array_id = item_array.split(' ')
      @price = FoodItem.find([@item_array_id]).pluck(:price)
      total= 0
      total_count = @quantities.count
      total_count.times do |i|
        if @quantities[i] != 0
          total += @quantities[i] * @price[i]
        end
      end
      return total
    end
end

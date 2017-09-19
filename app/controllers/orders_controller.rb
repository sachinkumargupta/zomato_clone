class OrdersController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user_or_admin, only: [:destroy, :show]

  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    Order.joins(:users)
    if current_user.admin?
      @orders = @restaurant.orders
    else  
      @orders = @restaurant.orders.where(user_id: current_user.id)
    end
  end
  
  def show
    @restaurant = Restaurant.find(params[:restaurant_id])
    Order.joins(:food_items)
    @order = Order.find(params[:id])
    generate_item_array_quantity_array_price_and_name(@order.item_array, @order.quantity_array)
    @order_array = @name.zip(@quantities,@price)
  end
  
  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @order = Order.new
    @food_items = @restaurant.food_items.all
  end
  
  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @food_items = @restaurant.food_items.all
    @order = @restaurant.orders.new(order_params)
    @order.user_id = current_user.id
    @order.total = calculate_total(@order.item_array,@order.quantity_array)

    if @order.save
      redirect_to restaurant_order_path(@restaurant, @order), notice: 'Order Placed successfully'
    else
      render :new
    end
  end
  
  def destroy

    @order.destroy
    redirect_to restaurant_orders_path(@restaurant)
  end

  private
    def order_params
      params.require(:order).permit(:item_array, :quantity_array, :total ,:delivery_address)
    end

    def correct_user_or_admin
      @restaurant = Restaurant.find(params[:restaurant_id])
      @order = @restaurant.orders.find(params[:id])
      unless current_user.id == @order.user_id || current_user.admin?
        flash[:danger] = "Access Denied"
        redirect_to restaurant_path(@restaurant)
      end
    end

    def generate_item_array_quantity_array_price_and_name(item_array, quantity_array)
      @items_id = item_array.split(', ')
      @quantities = quantity_array.split(', ').map(&:to_i)
      @price = FoodItem.find(@items_id).pluck(:price)
      @name = FoodItem.find(@items_id).pluck(:name)
    end

    def calculate_total(item_array, quantity_array)
      generate_item_array_quantity_array_price_and_name(item_array, quantity_array)
      total= 0 
      total_item = @items_id.count
      total_item.times do |i|
        total += @quantities[i] * @price[i]
      end
      return total
    end
end

class OrdersController < ApplicationController
  before_action :logged_in_user
  #before_action :correct_user_or_admin

  def index
    @restaurant = Restaurant.find(params[:restaurant_id])
    @orders = @restaurant.orders
  end
  
  def show
    @restaurant = Restaurant.find(params[:restaurant_id])
    @order = Order.find(params[:id]) 
  end
  
  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @order = Order.new
  end
  
  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @order = @restaurant.orders.new(order_params)
    @order.user_id = current_user.id

    if @order.save
      redirect_to restaurant_order_path(@restaurant, @order), notice: 'Order Placed successfully'
    else
      render :new
    end
  end
  
  def destroy
    @restaurant = Restaurant.find(params[:restaurant_id])
      @order = @restaurant.orders.find(params[:id])
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
end

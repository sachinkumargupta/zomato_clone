class BookTablesController < ApplicationController
  before_action :logged_in_user
  before_action :find_restaurant
  before_action :correct_user_or_admin, only: [:destroy, :show]

  def index
    if current_user.admin?
      @book_tables = @restaurant.book_tables.includes(:user)
    else
      @book_tables = @restaurant.book_tables.includes(:user).where(user_id: current_user.id)
    end
  end
  
  def show
    @book_table = BookTable.find(params[:id]) 
  end
  
  def new
    @book_table = BookTable.new
    @book_tables = @restaurant.book_tables
  end
  
  def create
    @book_table = @restaurant.book_tables.new(book_table_params)
    @book_table.user_id = current_user.id
    if @book_table.save
      flash[:success] = "Table Booked successfully"
      redirect_to restaurant_book_table_path(@restaurant, @book_table)
    else
      render :new
    end
  end
  
  def destroy
    @book_table = BookTable.find(params[:id])
    @book_table.destroy
    flash[:success] = "Table cancelled successfully"
    redirect_to restaurant_book_tables_path(@restaurant)
  end

  private
    def book_table_params
      params.require(:book_table).permit(:headcount, :date, :duration)
    end

    def find_restaurant
      @restaurant = Restaurant.find(params[:restaurant_id])
    end

    def correct_user_or_admin
      find_restaurant
      @book_table = @restaurant.book_tables.find(params[:id])
      unless current_user.id == @book_table.user_id || current_user.admin?
        flash[:danger] = "Access Denied"
        redirect_to restaurant_path(@restaurant)
      end
    end
end

#encoding:utf-8
class OrdersController < ApplicationController
  #before_filter :authenticate_user!
  def index
    @orders = Order.includes([:order_user, meal: :meal_type] )
    @meals = Meal.where(id:@orders.map(&:meal_id).uniq)
    @meal_types = MealType.where(id: @meals.map(&:mtype).uniq)
    # @meal_types_arr = @meal_types.map{|m| [m.id,m.name]}.to_h
    # @meals_arr = @meals.map{|m| [m.id,m.name]}.to_h
    @orders_groups = @orders.group_by{|r| r[:meal_id] }
    @orders_users_groups = @orders.group_by{|r| r[:user_id] }
    # binding.pry
    @shop=Shop.first
  end
  def new
   @meal_types = MealType.includes(:meals)
   @shop=Shop.first
   @orders = current_order_user.orders.includes(:meal)
  end
  def create
    @order  =Order.new(order_params)
    if @order.save
      redirect_to new_order_path
    else
      render 'orders/new'
    end
  end
  def delete
    @order  =Order.find(params[:id])
    if @order.destroy
      render :text=>1
    else
      render :text=>2
    end
  end
  def paying
    #orders =Order.all
    #Order.delete(orders.join(','))
    users=OrderUser.where('status = 1')
    users.each do |u|
      u.update_attribute(:status,0)
    end
    Order.delete_all
    redirect_to root_path
  end
  def open
     @shop=Shop.find(1)
     flag=false
     if(!@shop.status)
       flag=true
     end
     @shop.update_attribute(:status,flag)
     redirect_to orders_path
  end
  private
    def order_params
      params.require(:order).permit(:meal_id,:user_id,:num)
    end
end

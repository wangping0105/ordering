#encoding:utf-8
class OrdersController < ApplicationController
  #before_filter :authenticate_user!
  def index
    @orders =Order.find_by_sql('select o.id,m.name,m.price,o.num,o.Subtotal,m.mtype,u.uname,u.status from orders o inner join meals m on m.id=o.meal_id inner join order_users u on u.id=o.user_id')
    @meals=@orders.group_by{|r| r[:mtype] }
    @orders1 =Order.find_by_sql('select o.id,m.name,m.price,o.num,o.Subtotal,m.mtype,u.uname,u.status from orders o inner join meals m on m.id=o.meal_id inner join order_users u on u.id=o.user_id')
    @meals_by_person1 =@orders1.group_by{|s| s[:uname] }
    @meals_by_person =Array.new
    @meals_by_person = @meals_by_person1
    @shop=Shop.first
  end
  def new
   @shop=Shop.first
   @orders =Order.find_by_sql("select o.id,m.name,m.price,o.num,o.Subtotal,m.mtype,u.uname from orders o inner join meals m on m.id=o.meal_id inner join order_users u on u.id=o.user_id where u.id=#{current_order_user.id}")
   @meals=@orders.group_by{|r| r[:mtype] }

   meals =Meal.all
   @meals_g=meals.group_by{|m| m.mtype}
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

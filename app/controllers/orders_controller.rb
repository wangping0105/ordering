#encoding:utf-8
class OrdersController < ApplicationController
  #before_filter :authenticate_user!

  def index
    @orders = Order.includes(:order_user, meal:[:meal_type, :attachments]).current_orders
    @meals = Meal.where(id: @orders.map(&:meal_id).uniq)
    @meal_types = MealType.where(id: @meals.map(&:mtype).uniq).includes(:meals=>[:evaluations, :attachments])

    @orders_groups = @orders.group_by{|r| r[:meal_id] }
    @orders_users_groups = @orders.group_by{|r| r[:user_id] }
    @shop = Shop.first
  end

  def new
   @shop = Shop.first
   if @shop && @shop.status
     @orders = current_order_user.orders.includes(:meal).current_orders
     @meal_types = MealType.useing.includes(:meals => [:meal_type, :attachments, :evaluations])

     @order_histroys = current_order_user.orders.includes(:meal).order("created_at desc").page(params[:page])
   end
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
    users=OrderUser.where('status = 1')
    users.each do |u|
      u.update_attribute(:status,0)
    end
    flag = Time.now.to_i
    Order.update_all(Subtotal:flag, status:1 )
    redirect_to orders_path
  end

  def open
     @shop=Shop.find(1)
     flag=false
     if(!@shop.status)
       flag=true
       @shop.remember_order_time = Time.now
     else
       @shop.remember_order_time = nil
     end
     @shop.update_attribute(:status,flag)
     redirect_to orders_path
  end

  def talk
    content =  params[:content].strip
    if content.present?
       Talk.create(order_user:current_order_user, content: "<<#{MealType.useing.first.try(:name) || "无饭店"}>> #{content}")
    end
    @talks = Talk.limit(1000).order("created_at desc").includes(:order_user)
  end

  def show_talk_contents
    @talks = Talk.limit(200).order("created_at desc").includes(:order_user)
  end

  def random_order
    @meal_type =  MealType.where(id: params[:meal_type]).includes(:meals).first
    length = @meal_type.meals.size

    meal = @meal_type.meals[rand(length)]
    if meal
    Order.create({
                  meal_id: meal.id,
                  user_id: current_order_user.id,
                  num: 1
              })
    end

    redirect_to new_order_path
  end

  private
    def order_params
      params.require(:order).permit(:meal_id,:user_id,:num)
    end
end

class OrderUsersController < ApplicationController
  
  layout 'user'
  def index
    @user=OrderUser.new
  end
  def create
    @user1=OrderUser.find_by(uname:params[:order_user][:uname])
    if @user1.nil?
      @user=OrderUser.new
      @user.uname=params[:order_user][:uname]
      @user.role=0
      if @user.save
        signeed_in @user
        redirect_to new_order_path
      else
        render 'index'
      end
    else
      signeed_in @user1
      redirect_to new_order_path
    end
  end
  def pay
    user = OrderUser.find_by(uname:params[:id])
    user.update_attribute(:status,1)

   redirect_to orders_path
  end
end

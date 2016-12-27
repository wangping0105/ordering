class RankingsController < ApplicationController
  def index
    @meal_type = MealType.useing.includes(:meals).first
    if MealType.where(status:1).first
      meal_ids = @meal_type.meals
      @ranking_orders ||= Order.select("count(*) as count, meal_id").where(status:1).
        where(meal_id: meal_ids).group("meal_id").order("count desc").includes(:meal)
    end

    @user_orders = Order.select("count(*) total_count, user_id, users.truename").where(status:1).joins(:user).group(:user_id).order("count(*) desc")
    @user_orders = @user_orders.page(params[:page]).per(params[:per_page])
  end
end

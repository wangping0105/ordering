class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!,:get_meals

  include OrderUsersHelper

  def get_meals
    if MealType.where(status:1).first
      meal_ids = MealType.where(status:1).first.meals.select("meals.id").group("meals.id")
      @ranking_orders ||= Order.select("count(*) as count, meal_id").
          where(status:1).
          where(meal_id: meal_ids.map(&:id)).group("meal_id").order("count desc").includes(:meal)
    end
  end

end

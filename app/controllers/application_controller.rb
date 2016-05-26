class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!,:get_meals
  # before_action do
  #   Rack::MiniProfiler.authorize_request
  # end
  include OrderUsersHelper

  def get_meals
    _meal_type = MealType.useing.includes(:meals).first
    if MealType.where(status:1).first
      meal_ids = _meal_type.meals
      @ranking_orders ||= Order.select("count(*) as count, meal_id").where(status:1).
          where(meal_id: meal_ids).group("meal_id").order("count desc").includes(:meal)
    end
  end
end

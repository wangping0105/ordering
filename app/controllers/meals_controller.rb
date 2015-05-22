class MealsController < ApplicationController
  def index
    @meal_types = MealType.includes(:meals)
  end

  def new
    meals_groups = Meal.group_by(:mtype)
    @arr = []
    meals_groups.each {|m| @arr<<[m,m]}
    @meal = Meal.new
  end

  def create
    meal = Meal.new(meal_params)
    meal.save
    redirect_to action: :index
  end

  def destroy
    Meal.destroy(params[:id])
    redirect_to action: :index
  end

private
  def meal_params
    params.require(:meal).permit(:name, :price, :mtype)
  end
end

class MealTypesController < ApplicationController

  def change_meal_type
    if Shop.first.status
      flash[:error] = "请先结束本次饭馆!"
    else
      mealtype = MealType.find_by(id: params[:meal_type][:id])
      mealtype.can_use if mealtype
    end

    redirect_to meals_path(meal_type_id: params[:meal_type][:id])
  end

  def new
  end

  def create
    meal = MealType.new(meal_params)
    meal.save
    redirect_to meals_path( meal_type_id: params[:meal_type_id])
  end

  def destroy
    MealType.destroy(params[:id])
    redirect_to meals_path
  end

private
  def meal_params
    params.require(:meal_type).permit(:name)
  end
end

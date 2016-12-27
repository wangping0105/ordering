#暂时为饭馆
class MealTypesController < ApplicationController

  def index
    @current_meal_type = MealType.useing.first
    @all_meal_types = MealType.includes(:meals=>[:evaluations, :attachments])

    @meal_types = MealType.order(id: :desc).page(params[:page]).per(params[:per_page])
  end

  def change_meal_type
    if Shop.first.status
      flash[:error] = "请先付款并且结束订餐!"

    else
      mealtype = MealType.find_by(id: params[:id])
      if mealtype
        mealtype.can_use
        flash[:success] = "选择#{mealtype.name}成功!"
      end

      redirect_to meals_path(meal_type_id: params[:id])
    end
  end

  def new
  end

  def create
    meal = MealType.new(meal_params)
    meal.save
    redirect_to meal_types_path
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

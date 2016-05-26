class MealsController < ApplicationController
  RailsRootPath = Rails.root.to_s

  def index
    @meal_type = MealType.useing.first
    params[:meal_type_id] ||= (@meal_type.try(:id ) || MealType.first.try(:id))
    @all_meal_types = MealType.includes(:meals=>[:evaluations, :attachments])
    @meal_types = @all_meal_types.where(id: params[:meal_type_id])
  end

  def new
    meals_groups = Meal.group_by(:mtype)
    @arr = []
    meals_groups.each {|m| @arr<<[m,m]}
    @meal = Meal.new
  end

  def create
    meal = Meal.new(meal_params)
    meal.price = meal.price.to_f
    if meal.save
      redirect_to meals_path( meal_type_id: params[:meal_type_id])
    else
      redirect_to meals_path( meal_type_id: params[:meal_type_id])
    end
  end

  def add_attachments
    if params[:attachment].present?
      file = params[:attachment]
      new_file_name = "#{current_order_user.id}#{Time.now.to_i}#{file.original_filename}"
      file_dir = "#{RailsRootPath}/public/system/attachments/meals"
      _file_path = "/system/attachments/meals/#{new_file_name}"
      file_path = "#{file_dir}/#{new_file_name}"
      FileUtils.mkdir_p file_dir unless File.exist?(file_dir)

      meal = Meal.find_by(id: params[:meal_id])
      meal.attachments.build(name: file.original_filename,
                             file_path: _file_path,
                             file_content_type: file.content_type,
                             file_size: file.size,
                             order_user_id: current_order_user.id
      )
      if meal.save
        new_file = File.new(file_path, "wb")
        FileUtils.cp file.tempfile, new_file
        flash[:success] = '上传成功'
      else
        flash[:error] = '上传失败'
      end
    end
    redirect_to '/meals'
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

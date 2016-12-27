namespace :meals do
  desc "数据迁移"
  task run: :environment do
    MealType.transaction do
      MealType.find_each do |mt|
        sql = ActiveRecord::Base.connection()
        sql.insert "update meal_types set meals_count= #{mt.meals.count} where id= #{mt.id}"
      end
    end

    puts "over!"
  end
end

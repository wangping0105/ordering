class AddCloumnToMealTypes < ActiveRecord::Migration
  def change
    add_column :meal_types, :meals_count, :integer, default: 0
  end
end

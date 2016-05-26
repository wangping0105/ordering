class AddColumnToMealTypes < ActiveRecord::Migration
  def change
    add_column :orders, :status, :integer
    add_column :meal_types, :status, :integer
  end
end

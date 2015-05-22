class CreateMealTypes < ActiveRecord::Migration
  def change
    create_table :meal_types do |t|
      t.string :name
      t.integer :store_id
      t.timestamps null: false
    end
    change_column :meals, :mtype , :integer

  end
end

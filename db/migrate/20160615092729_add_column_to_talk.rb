class AddColumnToTalk < ActiveRecord::Migration
  def change

    add_column :talks, :meal_type_id, :integer, index: true
  end
end

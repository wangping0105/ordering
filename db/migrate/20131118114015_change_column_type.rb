class ChangeColumnType < ActiveRecord::Migration
  def change
     remove_column :meals, :type
     add_column :meals, :mtype,:string
  end
end

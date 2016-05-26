class AddColumnToShops < ActiveRecord::Migration
  def change
    add_column :shops , :remember_order_time , :datetime
  end
end

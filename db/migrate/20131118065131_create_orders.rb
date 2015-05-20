class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :meal_id
      t.integer :num
      t.integer :Subtotal

      t.timestamps
    end
  end
end

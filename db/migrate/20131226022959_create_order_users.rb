class CreateOrderUsers < ActiveRecord::Migration
  def change
    create_table :order_users do |t|
      t.string :uname
      t.integer :role

      t.timestamps
    end
  end
end

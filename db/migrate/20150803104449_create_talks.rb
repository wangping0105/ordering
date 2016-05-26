class CreateTalks < ActiveRecord::Migration
  def change
    create_table :talks do |t|
      t.text :content
      t.integer :order_user_id, index:true

      t.timestamps null: false
    end

  end
end

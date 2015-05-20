class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :sname
      t.timestamp :begin_time
      t.timestamp :end_time
      t.boolean :status

      t.timestamps
    end
  end
end

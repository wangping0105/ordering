class CreateOperationLogs < ActiveRecord::Migration
  def change
    create_table :operation_logs do |t|
      t.references :user, index: true
      t.string :action
      t.string :loggable_type
      t.integer :loggable_id
      t.text :note

      t.timestamps null: false
    end

    add_index :operation_logs, :loggable_id
    add_index :operation_logs, :loggable_type
    add_index :operation_logs, :action
  end
end

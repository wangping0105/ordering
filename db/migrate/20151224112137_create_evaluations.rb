class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.references :user
      t.integer :evaluatable_id
      t.string :evaluatable_type
      t.integer :types

      t.timestamps null: false
    end
  end
end

class AddColumnsToUser < ActiveRecord::Migration
  def change
    remove_column :talks, :order_user_id
    remove_column :evaluations, :order_user_id
    remove_column :users, :password

    add_column :talks, :user_id, :integer, index: true, after: :content
    add_column :evaluations, :user_id, :integer, index: true, before: :evaluatable_id
    add_column :users, :role, :integer, default: 0, index: true
    add_column :users, :pinyin, :string, after: :username
    add_column :users, :phone, :string, index: true, after: :pinyin
    add_column :users, :status, :integer, default: 0, commnet: '状态', after: :phone
    add_column :users, :deleted_at, :string, index: true, after: :status
  end
end

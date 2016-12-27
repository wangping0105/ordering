class AddColumnsToAttachment < ActiveRecord::Migration
  def change
    add_column :attachments, :user_id, :integer, index: true, after: :name
  end
end

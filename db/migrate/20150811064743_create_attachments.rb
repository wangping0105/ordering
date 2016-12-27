class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :name
      t.string :file_path
      t.string :file_content_type
      t.integer :file_size
      t.integer :attachmentable_id
      t.string :attachmentable_type
      t.datetime :deleted_at
      t.text     :remark
      t.string   :sub_type
      t.references :user, polymorphic: true, index: true

      t.timestamps null: false
    end

    add_index "attachments", ["attachmentable_id", "attachmentable_type"], name: "index_attachments_on_attachmentable_id_and_attachmentable_type", using: :btree
    add_index "attachments", ["deleted_at"], name: "index_attachments_on_deleted_at", using: :btree
    add_index "attachments", ["order_user_id"], name: "index_attachments_on_user_id", using: :btree
  end
end

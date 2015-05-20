class AddColumn < ActiveRecord::Migration
  def change
    add_column :order_users,:status ,:boolean,default:false
  end
end

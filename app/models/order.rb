class Order < ActiveRecord::Base
  belongs_to :order_user, foreign_key: :user_id
  belongs_to :meal

  scope :current_orders, ->{ where(status: nil )}

end

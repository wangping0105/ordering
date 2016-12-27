class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :meal

  scope :current_orders, ->{ where(status: nil )}

end

class Order < ActiveRecord::Base
  belongs_to :order_user
  belongs_to :meal
end

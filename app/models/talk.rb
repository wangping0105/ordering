class Talk < ActiveRecord::Base
  belongs_to :order_user
  belongs_to :meal_type
end

class Talk < ActiveRecord::Base
  belongs_to :user
  belongs_to :meal_type
end

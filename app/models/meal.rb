class Meal < ActiveRecord::Base
  has_many :orders
end

class MealType < ActiveRecord::Base
  has_many :meals, foreign_key: :mtype
  has_many :orders
end

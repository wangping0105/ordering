class Meal < ActiveRecord::Base
  has_many :orders
  belongs_to :meal_type , foreign_key: :mtype
end

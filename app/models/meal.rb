class Meal < ActiveRecord::Base
  has_many :orders
  belongs_to :meal_type , foreign_key: :mtype
  has_many :attachments, as: :attachmentable
  has_many :evaluations, as: :evaluatable
end

class MealType < ActiveRecord::Base
  has_many :meals, foreign_key: :mtype
  has_many :orders

  scope :useing, ->{where(status:1)}

  def can_use
    MealType.useing.each{|a| a.update(status:0)
    }
    self.update(status:1)
  end

end

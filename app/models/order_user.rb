class OrderUser < ActiveRecord::Base
  has_many :orders


  def admin?
    role == 1 ? true : false
  end
end

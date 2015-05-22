class OrderUser < ActiveRecord::Base
  has_many :orders, foreign_key: :user_id


  def admin?
    role == 1 ? true : false
  end
end

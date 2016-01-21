class OrderUser < ActiveRecord::Base
  has_many :orders, foreign_key: :user_id
  has_many :evaluations


  def admin?
    role == 1 ? true : false
  end


  def designation
    designations =  ["逗比", "大逗比", "超级大逗比", "神级逗比", "我是好人", "二比青年", "四有青年", "高富美", "白富帅"]
    if admin?
      "帅哥美女管理员"
    else
      designations[id%designations.size]
    end
  end

end

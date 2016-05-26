class Evaluation < ActiveRecord::Base
  belongs_to :order_user
  belongs_to :evaluatable, polymorphic: true
  enum :types =>{good: 0, common: 1, bad: 2}

  def types_i18n
    case types
      when "good"
        "好"
      when "common"
        "一般"
      when "bad"
        "差"
    end
  end
end

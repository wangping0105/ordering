class User < ActiveRecord::Base
  has_many :orders
  has_many :talks
  has_many :evaluations
  has_many :operation_logs

  include EntityQueryable
  include UserDestroyable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable#, :validatable
  has_many :attachments, as: :attachmentable
  validates_uniqueness_of :phone#, conditions: -> { paranoia_scope }

  before_create do
    self.username ||= self.phone
    self.password ||= "111111"
    self.pinyin = PinYin.of_string(self.username).join('').first(255)
    self.email = "#{self.pinyin}@ikcrm.com" if self.email.blank?
  end

  def admin?
    role == 1 ? true : false
  end

  def designation
    designations =  ["双杀", "逗比", "大逗比", "超级大逗比", "神级逗比", "我是好人", "二比青年", "四有青年", "高富美", "白富帅", "二二哒", '我是小明', '汪星人', '喵星人', '超神']
    if admin?
      "帅哥美女管理员"
    else
      designations[id%designations.size]
    end
  end

  def model_name_i18n
    I18n.t("activerecord.models.#{self.class.name.underscore}")
  end

  def to_s
    "#{truename}"
  end
end

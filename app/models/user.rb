class User < ActiveRecord::Base
  has_many :orders
  has_many :talks
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :attachments, as: :attachmentable

end

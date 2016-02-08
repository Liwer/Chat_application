class User < ActiveRecord::Base
  #Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :authentication_keys => [ :username]
  def email_required?
    false
  end
  def email_changed?
    false
  end
  def self.all_except(user)
    where.not(id: user)
  end
  validates_presence_of :username
  validates_uniqueness_of :username
  has_many :user_chats
  has_many :chats, through: :user_chats
  has_many :messages
end

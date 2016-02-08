class Chat < ActiveRecord::Base
  has_many :messages
  has_many :user_chats
  has_many :users, through: :user_chats
  accepts_nested_attributes_for :user_chats
end

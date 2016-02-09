class Message < ActiveRecord::Base
  acts_as_readable :on => :created_at
  belongs_to :user
  belongs_to :chat
end

class UserChat < ActiveRecord::Base
  belongs_to :user
  belongs_to :chat
  accepts_nested_attributes_for :user
end

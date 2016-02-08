class AddChatIdToMessage < ActiveRecord::Migration
  def change
    :messages, :chat_id, :integer
  end
end

class AddColumnToUserChat < ActiveRecord::Migration
  def change
    add_column :user_chats, :user_id, :integer
    add_column :user_chats, :chat_id, :integer
  end
end

class AddMessageIdToChat < ActiveRecord::Migration
  def change
    add_column :chats, :message_id, :integer
  end
end

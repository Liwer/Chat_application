class AddMessagesCountToUser < ActiveRecord::Migration
  def change
   add_column :users, :messages_count, :integer, :default => 0 
  end
end

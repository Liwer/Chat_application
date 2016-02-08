class CreateUserChats < ActiveRecord::Migration
  def change
    create_table :user_chats do |t|

      t.timestamps null: false
    end
  end
end

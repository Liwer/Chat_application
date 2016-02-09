class AddTextFieldToMessage < ActiveRecord::Migration
  def change 
    add_column :messages, :text, :text
  end
end

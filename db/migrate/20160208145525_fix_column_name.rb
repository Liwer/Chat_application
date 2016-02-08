class FixColumnName < ActiveRecord::Migration
  def self.up
    rename_column :users, :email, :username 
  end

  def self.down
  end

end

class AddBdayToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :birthday, :date, :null => false
  end

  def self.down
    remove_column :users, :birthday
  end
end

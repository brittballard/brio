class AddEventAndUserToSignup < ActiveRecord::Migration
  def self.up
    add_column :signups, :event_id, :int, :null => false
    add_column :signups, :user_id, :int
  end

  def self.down
    remove_column :signups, :event_id
    remove_column :signups, :user_id
  end
end

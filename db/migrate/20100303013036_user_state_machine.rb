class UserStateMachine < ActiveRecord::Migration
  def self.up
    add_column :users, :user_state, :string, :null => false, :precision => 50
  end

  def self.down
    remove_column :users, :user_state
  end
end

class AddStateColumnToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :event_state, :string, :null => false, :precision => 50
  end

  def self.down
    remove_column :events, :event_state
  end
end

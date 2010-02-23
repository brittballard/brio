class CreateEventUsersTable < ActiveRecord::Migration
  def self.up
    create_table :registrants, :id => false do |t|
      t.integer :event_id
      t.integer :user_id
    end
    
    create_table :volunteers, :id => false do |t|
      t.integer :event_id
      t.integer :user_id
    end
  end

  def self.down
    drop_table :registrants
    drop_table :volunteers
  end
end

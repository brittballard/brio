class ModifyJoinTables < ActiveRecord::Migration
  def self.up
    drop_table :registrants
    drop_table :volunteers
    
    create_table :events_registrants, :id => false do |t|
      t.references :event, :null => false
      t.references :user, :null => false
    end
    
    create_table :events_jobs_volunteers, :id => false do |t|
      t.references :event, :null => false
      t.references :user, :null => false
      t.references :job, :null => false
    end
    
    add_index :events_registrants, :event_id
    add_index :events_registrants, :user_id
    add_index :events_jobs_volunteers, :event_id
    add_index :events_jobs_volunteers, :user_id
    add_index :events_jobs_volunteers, :job_id
  end

  def self.down
    create_table :registrants, :id => false do |t|
      t.integer :event_id
      t.integer :user_id
    end
    
    create_table :volunteers, :id => false do |t|
      t.integer :event_id
      t.integer :user_id
    end
    
    drop_table :events_registrants
    drop_table :events_jobs_volunteers
  end
end

class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.timestamps
      t.title :string, :null => false, :limit => 50
      t.string :description, :null => false
      t.integer :number_of_volnteers, :null => false
      t.references :location, :null => false
      t.references :event, :null => false
      t.date_time :event_start_time, :null => false
      t.date_time :event_start_end, :null => false      
    end
    
    add_index :jobs, :event_id
  end

  def self.down
    drop_table :jobs
  end
end

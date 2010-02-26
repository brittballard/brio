class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.timestamps
      t.string :map_url, :null => false
      t.string :title, :null => false, :limit => 50
      t.string :description, :null => false, :limit => 200
      t.references :event, :null => false
      t.references :job, :null => false
      t.decimal :lat
      t.decimal :long
    end
    
    add_index :locations, :event_id
    add_index :locations, :job_id
    add_index :locations, [:event_id, :job_id]
  end

  def self.down
    drop_table :locations
  end
end

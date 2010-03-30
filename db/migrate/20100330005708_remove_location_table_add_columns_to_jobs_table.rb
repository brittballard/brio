class RemoveLocationTableAddColumnsToJobsTable < ActiveRecord::Migration
  def self.up
    drop_table(:locations)
    
    add_column(:jobs, :lat, :string, :limit => 50)
    add_column(:jobs, :lng, :string, :limit => 50)
    add_column(:jobs, :address_line_1, :string, :limit => 100)
    add_column(:jobs, :address_line_2, :string, :limit => 100)
    add_column(:jobs, :city, :string, :limit => 50)
    add_column(:jobs, :state, :string, :limit => 10)
    add_column(:jobs, :postal_code, :string, :limit => 9)
    add_column(:jobs, :title, :string, :limit => 50)
    remove_column(:jobs, :location_id)
    rename_column(:jobs, :number_of_volunteers, :number_of_volunteers_required)
  end

  def self.down
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
    
    remove_column(:jobs, :lat)
    remove_column(:jobs, :lng)
    remove_column(:jobs, :address_line_1)
    remove_column(:jobs, :address_line_2)
    remove_column(:jobs, :city)
    remove_column(:jobs, :state)
    remove_column(:jobs, :postal_code)
    remove_column(:jobs, :title)
    add_column(:jobs, :location_id, :integer)
    rename_column(:jobs, :number_of_volunteers_required, :number_of_volunteers)
  end
end

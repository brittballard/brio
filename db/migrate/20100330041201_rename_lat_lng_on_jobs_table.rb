class RenameLatLngOnJobsTable < ActiveRecord::Migration
  def self.up
    rename_column(:jobs, :lat, :latitude)
    rename_column(:jobs, :lng, :longitude)
  end

  def self.down
    rename_column(:jobs, :latitude, :lat)
    rename_column(:jobs, :longitude, :lng)
  end
end

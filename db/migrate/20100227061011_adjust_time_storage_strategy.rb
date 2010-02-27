class AdjustTimeStorageStrategy < ActiveRecord::Migration
  def self.up
    add_column :events, :time_zone, :string, :limit => 40
    rename_column :events, :start_date_time, :start_date
    rename_column :events, :end_date_time, :end_date
    rename_column :events, :registration_start_date_time, :registration_start_date
    rename_column :events, :registration_end_date_time, :registration_end_date
    add_column :events, :start_time, :time
    add_column :events, :end_time, :time
    add_column :events, :registration_end_time, :time
    add_column :events, :registration_start_time, :time
  end

  def self.down
    remove_column :events, :time_zone
    rename_column :events, :start_date, :start_date_time
    rename_column :events, :end_date, :end_date_time
    rename_column :events, :registration_start_date, :registration_start_date_time
    rename_column :events, :registration_end_date, :registration_end_date_time
    remove_column :events, :start_time
    remove_column :events, :end_time
    remove_column :events, :registration_end_time
    remove_column :events, :registration_start_time
  end
end

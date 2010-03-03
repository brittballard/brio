class AdjustDateTimeStrategyAgain < ActiveRecord::Migration
  def self.up
    remove_column :events, :end_time, :registration_end_time, :registration_start_time, :start_time

    rename_column :events, :start_date, :start_date_time
    rename_column :events, :end_date, :end_date_time
    rename_column :events, :registration_start_date, :registration_start_date_time
    rename_column :events, :registration_end_date, :registration_end_date_time

    change_column :events, :start_date_time, :datetime, :null => false
    change_column :events, :end_date_time, :datetime, :null => false
    change_column :events, :registration_start_date_time, :datetime
    change_column :events, :registration_end_date_time, :datetime

    add_column :users, :default_time_zone, :string, :limit => 40
  end

  def self.down
    add_column :events, :start_time, :time
    add_column :events, :end_time, :time
    add_column :events, :registration_end_time, :time
    add_column :events, :registration_start_time, :time
    
    rename_column :events, :start_date_time, :start_date
    rename_column :events, :end_date_time, :end_date
    rename_column :events, :registration_start_date_time, :registration_start_date
    rename_column :events, :registration_end_date_time, :registration_end_date

    change_column :events, :start_date, :date, :null => true
    change_column :events, :end_date, :date, :null => true
    change_column :events, :registration_start_date, :date
    change_column :events, :registration_end_date, :date

    remove_column :users, :default_time_zone
  end
end

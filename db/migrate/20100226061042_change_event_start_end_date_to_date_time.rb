class ChangeEventStartEndDateToDateTime < ActiveRecord::Migration
  def self.up
    remove_column :events, :start_date
    remove_column :events, :end_date
    rename_column :jobs, :start_date, :start_date_time
    rename_column :jobs, :end_date, :end_date_time
    add_column :events, :start_date_time, :datetime
    add_column :events, :end_date_time, :datetime
  end

  def self.down
    add_column :events, :start_date, :date
    add_column :events, :end_date, :date
    rename_column :jobs, :start_date_time, :start_date
    rename_column :jobs, :end_date_time, :end_date
    remove_column :events, :start_date_time
    remove_column :events, :end_date_time
  end
end

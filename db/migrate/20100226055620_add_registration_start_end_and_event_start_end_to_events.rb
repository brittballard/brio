class AddRegistrationStartEndAndEventStartEndToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :start_date, :date
    add_column :events, :end_date, :date
    add_column :events, :registration_start_date_time, :datetime
    add_column :events, :registration_end_date_time, :datetime
  end

  def self.down
    remove_column :events, :start_date
    remove_column :events, :end_date
    remove_column :events, :registration_start_date_time
    remove_column :events, :registration_end_date_time
  end
end

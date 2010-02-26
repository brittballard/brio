class AddStartDateEndDateToJobs < ActiveRecord::Migration
  def self.up
    add_column :jobs, :start_date, :datetime
    add_column :jobs, :end_date, :datetime
  end

  def self.down
    remove_columns :jobs, :start_date_time
    remove_columns :jobs, :end_date_time
  end
end

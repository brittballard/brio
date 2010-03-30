class Job < ActiveRecord::Base
  validates_presence_of :description, :start_date_time, :end_date_time, :address_line_1, :city, :state, :postal_code

  has_and_belongs_to_many :users, :join_table => 'events_jobs_registrants'
  has_and_belongs_to_many :events, :join_table => 'events_jobs_registrants'
  
  attr_accessor(:start_date, :start_hour, :start_minute, :end_date, :end_hour, :end_minute)
  
  def set_date_time(date_type)
    self.send("#{date_type}_date_time=", DateTime.parse(self.send("#{date_type}_date") + ' ' + self.send("#{date_type}_hour") + ':' + self.send("#{date_type}_minute")))
  end
end

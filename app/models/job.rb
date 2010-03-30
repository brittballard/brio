class Job < ActiveRecord::Base
  validates_presence_of :description, :start_date_time, :end_date_time, :address_line_1, :city, :state, :postal_code

  has_and_belongs_to_many :users, :join_table => 'events_jobs_registrants'
  has_and_belongs_to_many :events, :join_table => 'events_jobs_registrants'
end

class Job < ActiveRecord::Base
  validates_presence_of :description
  validates_presence_of :start_date_time
  validates_presence_of :end_date_time
  
  has_and_belongs_to_many :users, :join_table => 'events_jobs_registrants'
  has_and_belongs_to_many :events, :join_table => 'events_jobs_registrants'
end

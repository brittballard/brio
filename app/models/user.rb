class User < ActiveRecord::Base
  acts_as_authentic
    
  has_and_belongs_to_many :registered_events, :join_table => 'events_registrants', :class_name => 'Event'
  has_and_belongs_to_many :volunteering_events, :join_table => 'events_jobs_registrants', :class_name => 'Event'
end

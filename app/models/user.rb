class User < ActiveRecord::Base
  acts_as_authentic

  has_and_belongs_to_many :registrants, :class_name => 'Event'
    
  has_and_belongs_to_many :registered_events, :class_name => 'Event'
  has_and_belongs_to_many :volunteering_events, :class_name => 'Event'
end

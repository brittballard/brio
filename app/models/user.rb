class User < ActiveRecord::Base
  include AASM
  acts_as_authentic
    
  has_and_belongs_to_many :registered_events, :join_table => 'events_registrants', :class_name => 'Event'
  has_and_belongs_to_many :volunteering_events, :join_table => 'events_jobs_registrants', :class_name => 'Event'
  
  # aasm things
  aasm_column :user_state
  aasm_initial_state :pending
  
  aasm_state :pending
  aasm_state :active
  aasm_state :inactive
  
  aasm_event :activate do
    transitions :to => :active, :from => [:pending, :inactive]
  end
  
  aasm_event :inactivate do
    transitions :to => :inactive, :from => [:active, :pending]
  end
end

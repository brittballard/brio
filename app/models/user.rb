class User < ActiveRecord::Base
  include AASM
  
  def age
    mage = Date.today.year - birthday_date.year
    
    if Date.today.month < birthday_date.month || 
    (Date.today.month == birthday_date.month && birthday_date.day >= Date.today.day)
      mage = mage - 1
    end
    mage
  end
  
  acts_as_authentic
    
  has_and_belongs_to_many :registered_events, :join_table => 'events_registrants', :class_name => 'Event'
  has_and_belongs_to_many :volunteering_events, :join_table => 'events_jobs_registrants', :class_name => 'Event'
  has_many :signups
  has_many :events
  
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

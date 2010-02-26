class Event < ActiveRecord::Base
  include AASM
  
  has_and_belongs_to_many :registrants, :class_name => 'User'
  has_and_belongs_to_many :volunteers, :class_name => 'User'

  validates_presence_of :title
  
  named_scope :setup, :conditions => {:event_state => 'setup'}
  named_scope :registration_open, :conditions => {:event_state => 'registration_open'}
  named_scope :registration_closed, :conditions => {:event_state => 'registration_closed'}
  named_scope :running, :conditions => {:event_state => 'running'}
  named_scope :complete, :conditions => {:event_state => 'complete'}
    
  # aasm things
  aasm_column :event_state
  aasm_initial_state :setup
  
  aasm_state :setup
  aasm_state :registration_open
  aasm_state :registration_closed
  aasm_state :running
  aasm_state :complete
  
  aasm_event :open_registration do
    transitions :to => :registration_open, :from => [:setup, :registration_closed], :guard => :is_complete?
  end
  
  aasm_event :return_to_setup do
    transitions :to => :setup, :from => [:registration_open]
  end
  
  aasm_event :close_registration do
    transitions :to => :registration_closed, :from => [:registration_open]
  end
  
  aasm_event :run do
    transitions :to => :running, :from => [:registration_closed]
  end   
  
  aasm_event :complete do
    transitions :to => :complete, :from => [:running]
  end
  
  def is_complete?
    # are all the fields ready to go
    return true
  end
  
end

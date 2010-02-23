class Event < ActiveRecord::Base
  include AASM
  
  validates_presence_of :title
  
  # aasm things
  aasm_column :event_state
  aasm_initial_state :setup
  
  aasm_state :setup
  aasm_state :active
  aasm_state :running
  aasm_state :complete
  
  aasm_event :activate do
    transitions :to => :active, :from => [:setup], :guard => :is_complete?
  end
  
  def is_complete?
    # are all the fields ready to go
    return true
  end
  
end

class Signup < ActiveRecord::Base
  include AASM
  
  has_one :user
  has_one :event
  
  validate :age_of_user_is_greater_than_minimum_age_of_event
  
  def age_of_user_is_greater_than_minimum_age_of_event
    errors.add(user.birthday_date, "must be greater than the event's minimum age") if
    user.age < event.minimum_age_to_register
  end
  
  # aasm stuff
  aasm_column :signup_state
  aasm_initial_state :authorize
  
  aasm_state :authorize
  aasm_state :register
  aasm_state :pay
  aasm_state :complete
  aasm_state :abandoned
  
  aasm_event :register do
    transitions :to => :register, :from => [:authorize]
  end
  
  # add many users to the same signup
  aasm_event :add_user do
    transitions :to => :register, :from => [:register]
  end
  
  aasm_event :pay do
    transitions :to => :pay, :from => [:register]
  end
  
  aasm_event :complete do
    transitions :to => :complete, :from => [:pay]
  end
  
  aasm_event :abandon do
    transitions :to => :abandoned, :from => [:authorize, :register, :pay, :complete]
  end
end

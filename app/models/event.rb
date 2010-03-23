class Event < ActiveRecord::Base
  include AASM
  
  validates_presence_of :title, :description, :start_date_time, :end_date_time, :address_line_1, :city, :state, :postal_code
  validates_numericality_of :registration_fee
  validates_numericality_of :minimum_age_to_participate, :minimum_age_to_register, :allow_nil => true
  validates_format_of :latitude, :with => /\d+/, :allow_nil => true, :allow_blank => true
  validates_format_of :longitude, :with => /\d+/, :allow_nil => true, :allow_blank => true
  
  has_and_belongs_to_many :registrants, :join_table => 'events_registrants', :class_name => 'User'
  has_and_belongs_to_many :volunteers, :join_table => 'events_jobs_registrants', :class_name => 'User'
  has_and_belongs_to_many :signups, :join_table => 'events_signups', :class_name => 'User'
  
  named_scope :setup, :conditions => {:event_state => 'setup'}
  named_scope :registration_open, :conditions => {:event_state => 'registration_open'}
  named_scope :registration_closed, :conditions => {:event_state => 'registration_closed'}
  named_scope :running, :conditions => {:event_state => 'running'}
  named_scope :complete, :conditions => {:event_state => 'complete'}
  
  attr_accessor(:start_date, :start_hour, :start_minute,
                :end_date, :end_hour, :end_minute,
                :registration_start_date, :registration_start_hour, :registration_start_minute,
                :registration_end_date, :registration_end_hour, :registration_end_minute)
                
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

  def set_date_time(date_type)
    self.send("#{date_type}_date_time=", DateTime.parse(self.send("#{date_type}_date") + ' ' + self.send("#{date_type}_hour") + ':' + self.send("#{date_type}_minute")))
  end
  
  private
  
  def is_complete?
    # are all the fields ready to go
    return true
  end

  def validate
    errors.add(:start_date_time, "must be before end date.") if start_date_time >= end_date_time
    errors.add(:registration_start_date_time, "must be before registration end date") if registration_start_date.present? && registration_end_date.present? && registration_start_date_time >= registration_end_date_time
  end
end
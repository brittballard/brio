class Event < ActiveRecord::Base
  include AASM
  
  # macros
  
  validates_presence_of :title, :description, :start_date_time, :end_date_time, :address_line_1, :city, :state, :postal_code, :time_zone
  validates_numericality_of :registration_fee
  validates_numericality_of :minimum_age_to_participate, :minimum_age_to_register, :allow_nil => true
  validates_format_of :latitude, :with => /\d+\.\d+/, :allow_nil => true, :allow_blank => true
  validates_format_of :longitude, :with => /\d+\.\d+/, :allow_nil => true, :allow_blank => true
  
  has_and_belongs_to_many :registrants, :join_table => 'events_registrants', :class_name => 'User'
  has_and_belongs_to_many :volunteers, :join_table => 'events_jobs_registrants', :class_name => 'User'
  has_many :signups
  has_many :users, :through => :signups
  has_one :map, :dependent => :destroy
  
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
  
  # instance methods
  
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

  def self.search_open(params={})
    filter_events(params, :registration_open)
  end
  
  def self.search_my(params={})
    all(:joins => :registrants, :conditions => build_conditions_from_params(params))
  end
  
  def self.search_results(params={})
    filter_events(params, :complete)
  end

  private  
    def is_complete?
      # are all the fields ready to go
      return true
    end

    def validate
      errors.add(:start_date_time, "must be before end date.") if start_date_time.present? && end_date_time.present? && start_date_time >= end_date_time
      errors.add(:registration_start_date_time, "must be before registration end date") if registration_start_date_time.present? && registration_end_date_time.present? && registration_start_date_time >= registration_end_date_time
    end
    
    def self.filter_events(params, filter_named_scope)
      conditions = build_conditions_from_params(params)

      if conditions.any?
        events = send(filter_named_scope).all(:conditions => conditions)
      else
        events = send(filter_named_scope)
      end

      events
    end

    def self.build_conditions_from_params(params)
      conditions = []
      conditions_params = {}

      if params[:name].present?
        conditions << "title like :name"
        conditions_params.merge!({ :name => params[:name]})
      end

      if params[:date].present?
        conditions << ":date between start_date_time and end_date_time"
        conditions_params.merge!({ :date => params[:date]})
      end

      if params[:location].present?
        # what are we doing with locations
      end

      [conditions.any? ? conditions.join(' and ') : nil, conditions_params.any? ? conditions_params : nil].compact
    end
end
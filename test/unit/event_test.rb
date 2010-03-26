require 'test_helper'

class EventTest < ActiveSupport::TestCase
  subject { Factory.build(:event) }

  should_have_one(:map)
  should_have_and_belong_to_many(:registrants)
  should_validate_presence_of(:title, :description, :start_date_time, :end_date_time, :address_line_1, :city, :state, :postal_code, :time_zone)

  should_not_allow_values_for(:registration_fee, "abc")
  should_not_allow_values_for(:minimum_age_to_participate, "abc")
  should_not_allow_values_for(:minimum_age_to_register, "abc")
  should_not_allow_values_for(:latitude, "abc", 1)
  should_not_allow_values_for(:longitude, "abc", 1)
  
  should_allow_values_for(:registration_fee, 1)
  should_allow_values_for(:minimum_age_to_participate, 1)
  should_allow_values_for(:minimum_age_to_register, 1)
  should_allow_values_for(:latitude, 111.11)
  should_allow_values_for(:longitude, -35.00)
  
  context("creating events") do
    setup do
      @event = Factory.build(:event)
    end
    
    should("create a datetime value when a start_date, start_hour, and start_minute are provided") do
      @event.start_date   = "03/11/1980"
      @event.start_hour   = "5"
      @event.start_minute = "05"
      @event.set_date_time('start')
      assert_equal(DateTime.parse("03/11/1980 5:05"), @event.start_date_time)
    end
    
    should("fail if the start date is after end date") do
      @event.start_date_time  = Time.now
      @event.end_date_time    = 1.day.ago
      assert(!@event.save)
      assert_equal(1, @event.errors.length)
      assert(@event.errors[:start_date_time].present?)
    end
    
    should("fail if the registration start date is after the registration end date") do
      @event.registration_start_date_time  = Time.now
      @event.registration_end_date_time    = 1.day.ago
      assert(!@event.save)
      assert_equal(1, @event.errors.length)
      assert(@event.errors[:registration_start_date_time].present?)
    end
  end
  
  context("event states") do
    setup do
      @event = Factory.build(:event)
    end
    
    should("allow events to switch from setup to registration open") do
      @event.event_state = :setup
      @event.open_registration
      
      assert_equal("registration_open", @event.event_state)
    end
    
    should("allow events to switch from registration closed to registration open") do
      @event.event_state = :registration_closed
      @event.open_registration
      
      assert_equal("registration_open", @event.event_state)
    end
    
    should("allow events to switch from registration open to registration closed") do
      @event.event_state = :registration_open
      @event.close_registration
      
      assert_equal("registration_closed", @event.event_state)
    end
    
    should("allow events to switch from registration open to setup") do
      @event.event_state = :registration_open
      @event.return_to_setup
      
      assert_equal("setup", @event.event_state)
    end
    
    should("allow events to switch from registration closed to running") do
      @event.event_state = :registration_closed
      @event.run
      
      assert_equal("running", @event.event_state)
    end
    
    should("allow events to switch from running to complete") do
      @event.event_state = :running
      @event.complete
      
      assert_equal("complete", @event.event_state)
    end
    
    should("error when the open registration event is called and the event is in an illegal state") do
      @event.event_state = :registration_open
      assert_raise_invalid_transition { @event.open_registration }
      
      @event.event_state = :running
      assert_raise_invalid_transition { @event.open_registration }

      @event.event_state = :complete
      assert_raise_invalid_transition { @event.open_registration }
    end

    should("error when the return to setup event is called and the event is in an illegal state") do
      @event.event_state = :registration_closed
      assert_raise_invalid_transition { @event.return_to_setup }
      
      @event.event_state = :setup
      assert_raise_invalid_transition { @event.return_to_setup }

      @event.event_state = :running
      assert_raise_invalid_transition { @event.return_to_setup }

      @event.event_state = :complete
      assert_raise_invalid_transition { @event.return_to_setup }
    end

    should("error when the close registration event is called and the event is in an illegal state") do
      @event.event_state = :registration_closed
      assert_raise_invalid_transition { @event.close_registration }
      
      @event.event_state = :setup
      assert_raise_invalid_transition { @event.close_registration }

      @event.event_state = :running
      assert_raise_invalid_transition { @event.close_registration }

      @event.event_state = :complete
      assert_raise_invalid_transition { @event.close_registration }
    end

    should("error when the run event is called and the event is in an illegal state") do
      @event.event_state = :registration_open
      assert_raise_invalid_transition { @event.run }
      
      @event.event_state = :setup
      assert_raise_invalid_transition { @event.run }

      @event.event_state = :running
      assert_raise_invalid_transition { @event.run }

      @event.event_state = :complete
      assert_raise_invalid_transition { @event.run }
    end

    should("error when the complete event is called and the event is in an illegal state") do
      @event.event_state = :registration_open
      assert_raise_invalid_transition { @event.complete }
      
      @event.event_state = :setup
      assert_raise_invalid_transition { @event.complete }

      @event.event_state = :registration_open
      assert_raise_invalid_transition { @event.complete }

      @event.event_state = :complete
      assert_raise_invalid_transition { @event.complete }
    end
  end
  
  def assert_raise_invalid_transition
    assert_raise AASM::InvalidTransition do
      yield
    end
  end
end

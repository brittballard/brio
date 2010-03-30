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

  context('start_date_time method') do
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

  context("event filtering") do
    setup do
      @event_filter_service = EventFilterService.new(Event)
    end
    
    context('EventFilterService build_conditions_from_params method') do
      should("build the correct conditions when the build_conditions_from_params method is given a name param") do
        conditions = @event_filter_service.send(:build_conditions_from_params, { :name => 'britton' })

        assert_same_elements(["title like :name", { :name => 'britton' }], conditions)
      end
      
      should("build the correct conditions when the build_conditions_from_params method is given a date param") do
        now = Time.now
        conditions = @event_filter_service.send(:build_conditions_from_params, { :date => now })

        assert_same_elements([":date between start_date_time and end_date_time", { :date => now }], conditions)
      end

      should("build the correct conditions when the build_conditions_from_params method is given a date and name param") do
        now = Time.now
        conditions = @event_filter_service.send(:build_conditions_from_params, { :date => now, :name => 'britton' })

        assert_same_elements(["title like :name and :date between start_date_time and end_date_time", { :name => 'britton', :date => now }], conditions)
      end
    end

    context('EventFilterService') do
      context('search_open') do
        should("return all open events when no params are sent") do
          event = Factory.build(:event)
          event.title = 'filter events test'
          event.open_registration
          event.save
      
          events = @event_filter_service.search_open()
      
          assert events.select{ |event| event.title == 'filter events test' }.any?
          assert_equal Event.registration_open.length, events.length
        end

        should("return all events based on a name sent to the method") do
          event = Factory.build(:event)
          event.title = 'filter events test'
          event.open_registration
          event.save
      
          events = @event_filter_service.search_open({ :name => 'filter events test' })
      
          assert events.select{ |event| event.title == 'filter events test' }.any?
          assert_equal Event.registration_open.find_all_by_title('filter events test').length, events.length
        end
      end
    end
  end

  private

  def assert_raise_invalid_transition
    assert_raise AASM::InvalidTransition do
      yield
    end
  end
end

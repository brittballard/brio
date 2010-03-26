require 'test_helper'

class EventTest < ActiveSupport::TestCase
  subject { Factory.build(:event) }

  should_have_one(:map)
  should_have_and_belong_to_many(:registrants)
  should_validate_presence_of(:title, :description, :start_date_time, :end_date_time, :address_line_1, :city, :state, :postal_code, :time_zone)
  
  
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
end

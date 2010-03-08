require 'test_helper'

class EventTest < ActiveSupport::TestCase
  context "creating events" do
    should "create a datetime value when a start_date, start_hour, and start_minute are provided" do
      flexmock(Event)
      event = Factory.build(:event)
      event.start_date = "03/11/1980"
      event.start_hour = "5"
      event.start_minute = "05"
      event.set_date_time('start')
      assert_equal(DateTime.parse("03/11/1980 5:05"), event.start_date_time)
    end
  end
end

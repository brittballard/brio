require 'test_helper'

class JobTest < ActiveSupport::TestCase
  should_validate_presence_of(:description, :start_date_time, :end_date_time, :address_line_1, :city, :state, :postal_code)
  
  
end

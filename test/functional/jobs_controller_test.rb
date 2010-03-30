require 'test_helper'

class JobsControllerTest < ActionController::TestCase
  context("on POST to :create") do
    setup do
      post(:create, :job => Factory.attributes_for(:job), :event_id => Factory.create(:event).id)
    end
    
    should_set_the_flash_to('Job was successfully created.')
    should_assign_to(:job)
    should_respond_with(:redirect)
  end
end

require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  context("on get to :index show events") do
    setup do
      get(:index)
    end
    
    should_assign_to(:events)
    should_respond_with(:success)
    should_render_template(:index)
    should_not_set_the_flash
  end
end

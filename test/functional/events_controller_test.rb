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
  
  context("on get to :show with an id show event") do
    setup do
      event = Factory.create(:event)
      get(:show, { :id => event.id })
    end
    
    should_assign_to(:event)
    should_respond_with(:success)
    should_render_template(:show)
    should_not_set_the_flash
  end
  
  context("on get to :search_open with no params") do
    setup do
      event = Factory.build(:event)
      event.open_registration
      event.save
      get(:search_open)
    end
    
    should_assign_to(:events)
    should_respond_with(:success)
    should_render_template(:search_open)
    should_not_set_the_flash

    should("return all events") do
      assert_equal(Event.registration_open.count, assigns(:events).length)
    end
  end
end

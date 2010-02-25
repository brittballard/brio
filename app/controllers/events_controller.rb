class EventsController < ApplicationController
  def index
    @events = Event.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end
  
  def search
    # pair this down to use the filter dawg
    @events = Event.all
    
    respond_to do |format|
      format.html
    end
  end
  
  def new
    
  end
  
  def create
    
  end
end

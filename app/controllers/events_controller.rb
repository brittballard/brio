class EventsController < ApplicationController

  def show
    @event = Event.find(params[:id])
  end

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
    @event = Event.new
  end
  
  def create
    @event = @event.new(params[:event])
    
    if @event.save
      flash[:notice] = "Event created succesfully."
      redirec_to @event
    else
      flash[:error] = "Error creating event."
      redner :action => new
    end
  end
end

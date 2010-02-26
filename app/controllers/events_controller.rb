class EventsController < ApplicationController

  def index
    @events = Event.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end
  
  def create
    @event = Event.new(params[:event])
    
    if @event.save
      flash[:notice] = "Event created succesfully."
      redirect_to @event
    else
      flash[:error] = "Error creating event."
      render :action => 'new'
    end
  end

  def edit
    @event = Event.find(params[:id])
  end
  
  def update
    @event = Event.find(params[:id])
    
    if @event.update_attributes(params[:event])
      flash[:notice] = "Event updated succesfully."
      redirect_to @event
    else
      flash[:error] = "Error updating event."
      render :action => 'edit'
    end
  end
  
  def search
    # pair this down to use the filter dawg
    @events = Event.all
    
    respond_to do |format|
      format.html
    end
  end

end

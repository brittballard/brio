class EventsController < ApplicationController
  before_filter :require_user, :only => [:search_my, :create, :update, :edit]
    
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

  def search_open
    # pull the search items out
    date = params[:date]
    name = params[:name].present? ? '%'+params[:name]+'%' : '%'
    location = params[:location]

    # pass that shit into the search homie and give it to the search list
    # WOH WOH WOH:  use the date to search that it is between the start and end date
    @events = Event.registration_open.all(:conditions => ["title LIKE ?", name])

    respond_to do |format|
      format.html
    end
  end

  def search_my
    # pull the search items out
    date = params[:date]
    name = params[:name].present? ? '%'+params[:name]+'%' : '%'
    location = params[:location]

    @events = Event.all(:joins => :registrants, :conditions => ["user_id = ? AND title LIKE ?", current_user.id, name])

    respond_to do |format|
      format.html
    end
  end

  def search_results
    # pull the search items out
    date = params[:date]
    name = params[:name].present? ? '%'+params[:name]+'%' : '%'
    location = params[:location]

    # pass that shit into the search homie and give it to the search list
    # WOH WOH WOH:  use the date to search that it is between the start and end date
    @events = Event.complete.all(:conditions => ["title LIKE ?", name])
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

end

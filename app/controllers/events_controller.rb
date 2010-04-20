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
    @events = Event.search_open(params)
    
    respond_to do |format|
      format.html
    end
  end

  def search_my
    @events = Event.search_my(params)

    respond_to do |format|
      format.html
    end
  end

  def search_results
    @events = Event.search_results(params)
    
    respond_to do |format|
      format.html
    end
  end

  def create
    @event = Event.new(params[:event])
    set_date_times(@event)
    
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

  private

  def set_date_times(event)
    set_date_time(event, 'start') if params[:event][:start_date].present?
    set_date_time(event, 'end') if params[:event][:end_date].present?
    set_date_time(event, 'registration_start') if params[:event][:registration_start_date].present?
    set_date_time(event, 'registration_end') if params[:event][:registration_end_date].present?
  end

  def set_date_time(event, date_type)
    event.set_date_time(date_type)
  end

end

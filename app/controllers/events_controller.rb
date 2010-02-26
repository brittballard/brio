class EventsController < ApplicationController
  def index
    @events = Event.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
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
    
    respond_to do |format|
      format.html
    end
  end
  
  def new
    
  end
  
  def create
    
  end
end

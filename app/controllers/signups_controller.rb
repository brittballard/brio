class SignupsController < ApplicationController
  def authorize
    @event = Event.find(params[:event_id])
    
    #set some event event specific properties on the page, like event name, disclaimer, etc.
  end
  
  def go_register
    #create new signup
    signup = Signup.new(params[:signup])
    
    if signup.save
      flash[:notice] = "Nice work buddy"
      render :action => "register"
    end
  end
  
  def register
    
  end
  
  def go_pay
    
  end
  
  def pay
    
  end
end
class SignupsController < ApplicationController
  def authorize
    @event = Event.find(params[:event_id])
    #@signup = Signup.new
    
    #set some event event specific properties on the page, like event name, disclaimer, etc.
  end
  
  def go_register
    #create new signup
    event_id = params[:event_id]
    user_id = current_user.blank? ? nil : current_user.id
    
    @signup = Signup.new(params[:signup])
    @signup.event_id = event_id
    @signup.user_id = user_id
    
    #hook up accepted terms correctly
    #if they accept the terms set the cookie, otherwise don't let em by
    
    cookies[event_id] = @signup.accepted_terms
    
    if @signup.save
      flash[:notice] = "Nice work buddy"
      redirect_to register_signup_path(@signup)
    else
      flash[:notice] = "You suck wanker"
    end
  end
  
  def register
    @signup = Signup.find(params[:id])
      
    if cookies[@signup.event_id].nil? or cookies[@signup.event_id].empty? or cookies[@signup.event_id] = false
      redirect_to events_path
      flash[:notice] = "You didn't accept the terms."
    else
      #need to verify this is a valid signup for the current user
      #also need to hook up being able to sign in from here, and populate data from the signed in user, if possible
      @user = User.new()
    end
  end
  
  def go_pay
    @user = User.new(params[:user])
    @signup = Signup.find(params[:id])

    if @user.save
      @signup.user_id = @user.id
      
      if @signup.save
        render(:action => 'pay')
      end
    else
      flash[:error] = "Error saving!"
    end
  end
  
  def pay
    debugger
    @signup = Signup.find(params[:id])
  end
end
class SignupsController < ApplicationController
  def authorize
    @event = Event.find(params[:event_id])
    
    #set some event event specific properties on the page, like event name, disclaimer, etc.
  end
  
  def go_register
    #create new signup
    event_id = params[:event_id]
    user_id = current_user.blank? ? nil : current_user.id
    
    signup = Signup.new()
    signup.event_id = event_id
    signup.user_id = user_id
    
    #hook up accepted terms correctly
    signup.accepted_terms = true
    
    if signup.save
      flash[:notice] = "Nice work buddy"
      redirect_to register_signup_path(signup)
    else
      flash[:notice] = "You suck wanker"
    end
  end
  
  def register
    #need to verify this is a valid signup for the current user
    #also need to hook up being able to sign in from here, and populate data from the signed in user, if possible
    @signup = Signup.find(params[:id])
    @user = User.new()
  end
  
  def go_pay
    @user = User.new(params[:user])
    @signup = Signup.find(params[:id])

    if @user.save!
      @signup.user_id = @user.id
      
      if @signup.save!
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
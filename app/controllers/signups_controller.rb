class SignupsController < ApplicationController
  def authorize
    @event = Event.find(params[:event_id])
  end
  
  def go_register
    @signup = Signup.new(params[:signup])
    @signup.event = Event.find(@signup.event_id)
    
    @signup.user = @signup.user_id.present? ? User.find(@signup.user_id) : User.new(params[:user])
    @signup.user.user_state = "pending"
    @signup.user.email = ""
    @signup.user.save(false)
      
    cookies[@signup.event_id] = @signup.accepted_terms
    
    if @signup.save
      flash[:notice] = "Nice work buddy"
      redirect_to register_signup_path(@signup)
    else
      redirect_to authorize_event_signups_path(@signup.event)
    end
  end
  
  def register
    @signup = Signup.find(params[:id])
      
    if cookies[@signup.event_id].nil? or cookies[@signup.event_id].empty? or cookies[@signup.event_id] == false
      redirect_to events_path
      flash[:notice] = "You didn't accept the terms."
    else
      #need to verify this is a valid signup for the current user
      #also need to hook up being able to sign in from here, and populate data from the signed in user, if possible
      @user = @signup.user
    end
  end
  
  def go_pay
    #@user = User.new(params[:user])
    @signup = Signup.find(params[:id])
    
    if @current_user.nil? and params[:show_password]["show_password"] == "0"
      debugger
      @user.save(false)
      @signup.user_id = @user.id
      @signup.user = @user
      if @signup.save
        render(:action => 'pay')
      end
    elsif @user.save
      @signup.user_id = @user.id
      
      if @signup.save
        render(:action => 'pay')
      end
    else
      render 'register'
    end
  end
  
  def pay
    debugger
    @signup = Signup.find(params[:id])
  end
end
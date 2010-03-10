class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create, :add_to_event, :show]
  before_filter :require_user, :only => [:show, :edit, :update]
  
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    @user.activate
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_back_or_default account_url
    else
      render :action => :new
    end
  end
  
  def show
    @user = @current_user
  end
 
  def edit
    @user = @current_user
  end
  
  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end
  
  def index
    @event = Event.find_by_id(params[:event_id])
    @users = User.all(:conditions => ["id = ?", params[:event_id]])
  end
  
  def add_to_event
    @event = Event.find_by_id(params[:event_id]) 
    @user = User.new(params[:user])
      if(@user.save)
        flash[:notice] = "Account registered!"
        event_users_url(@event)
      else
        add_to_event_users_url(@event)
     end
  end
end
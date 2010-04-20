ActionController::Routing::Routes.draw do |map|
  map.root :controller => "events"
  
  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"
  
  map.resource :account, :controller => "users"
  map.resources :events, :collection => { :search_open => [:post, :get], :search_my => [:post, :get], :search_results => [:post, :get] }, :has_many => :users do |event|
    event.resources :jobs, :only => [:new, :create]
    event.resources :users, :collection => { :add_to_event => [:post] }, :only => [:add_to_event]
    event.resources :signups, :collection => { :authorize => [:get], :go_register => [:post] }, :only => [:authorize]
  end
  map.resources :jobs, :only => [:show, :index]
  map.resources :maps
  map.resources :map_datapoints
  map.resources :signups, :member => { :register => [:get], :go_pay => [:post], :pay => [:get] }
  map.resources :users, :has_many => :jobs
  map.resource :user_session
end
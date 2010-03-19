ActionController::Routing::Routes.draw do |map|
  map.resources :events, :collection => { :search_open => [:post, :get], :search_my => [:post, :get], :search_results => [:post, :get] }, :has_many => :users
  map.resource :account, :controller => "users"
  map.resources :users
  map.resources :users, :collection => { :add_to_event => [:post] }, :path_prefix => "/events/:event_id", :only => [:add_to_event]
  #map.resources :users, :path_prefix => '/events/:event_id', :only => [:add_to_event]
  map.resource :user_session
  map.resources :signups, :collection => { :authorize => [:get], :go_register => [:post] }, :path_prefix => "events/:event_id", :only => [:authorize]
  map.resources :signups, :member => { :register => [:get], :go_pay => [:post], :pay => [:get] }
  
  map.root :controller => "events"
  
  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"
end

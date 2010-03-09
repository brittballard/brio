ActionController::Routing::Routes.draw do |map|
  map.resources :events, :collection => { :search_open => [:post, :get], :search_my => [:post, :get], :search_results => [:post, :get] }, :has_many => :users
  map.resource :account, :controller => "users"
  map.resources :users
  map.resources :users, :collection => { :add_to_event => [:post] }, :path_prefix => "/events/:event_id", :only => [:add_to_event]
  #map.resources :users, :path_prefix => '/events/:event_id', :only => [:add_to_event]
  map.resource :user_session
  map.resource :signup, :collection => { :authorize => [:get], :go_register => [:post] }, :path_prefix => "events/:event_id", :only => [:authorize]
  map.resources :signup, :collection => { :register => [:get], :go_pay => [:post], :pay => [:get] }
  
  map.root :controller => "events"
end

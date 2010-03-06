ActionController::Routing::Routes.draw do |map|
  map.resources :sonars

  map.resources :events, :collection => { :search_open => [:post, :get], :search_my => [:post, :get], :search_results => [:post, :get] }, :has_many => :users
  map.resource :account, :controller => "users"
  map.resources :users
  map.resources :users, :collection => { :add_to_event => [:post] }, :path_prefix => "/events/:event_id", :only => [:add_to_event]
  #map.resources :users, :path_prefix => '/events/:event_id', :only => [:add_to_event]
  map.resource :user_session, :collection => { :login => [:post] }
  map.resources :sonars

  map.root :controller => "events"
end

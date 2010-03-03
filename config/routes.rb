ActionController::Routing::Routes.draw do |map|
  map.resources :events, :collection => { :search_open => [:post, :get], :search_my => [:post, :get], :search_results => [:post, :get] }
  
  map.resource :account, :controller => "users"
  map.resources :users
  map.resource :user_session

  map.root :controller => "events"
end

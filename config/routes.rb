ActionController::Routing::Routes.draw do |map|
  map.resources :events, :collection => { :search => [:get, :post] }
  
  map.resource :account, :controller => "users"
  map.resources :users
  map.resource :user_session

  map.root :controller => "user_sessions", :action => "new"
end

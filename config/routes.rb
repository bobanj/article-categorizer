ActionController::Routing::Routes.draw do |map|
  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"

  map.resources :user_sessions
  map.resources :users
  map.resource :account, :controller => "users"
  map.resources :portals
  map.resources :categories
  map.resources :articles

  # ROOT
  map.root :controller => :main

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

GoalApp::Application.routes.draw do
  resources :users
  resource :session
  resources :goals
  resources :cheers, :only => :create
end

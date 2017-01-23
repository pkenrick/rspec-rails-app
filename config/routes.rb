Rails.application.routes.draw do
  get 'sessions/new'

  get 'users/show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users
  resources :sessions
end

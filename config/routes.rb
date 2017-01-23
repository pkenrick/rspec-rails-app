Rails.application.routes.draw do
  get 'activations/new'

  get 'sessions/new'

  get 'users/show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users
  resources :sessions
  resources :activations
  get '/activations/activate/:id', to: 'activations#activate', as: :activate_account
end

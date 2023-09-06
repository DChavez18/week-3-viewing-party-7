Rails.application.routes.draw do
  root 'welcome#index'

  get '/login', to: "users#login_form"
  post '/login', to: "users#login"
  get '/logout', to: "users#logout"
  get '/dashboard', to: "users#show", as: :dashboard
  get '/movies/:id', to: 'movies#show', as: :movie
  get '/register', to: 'users#new'
  post '/users', to: 'users#create'
  # get '/users/:user_id/movies/:id', to: 'movies#show', as: 'movie'
  
  resources :movies, only: [:show] do
    resources :viewing_party, only: [:new]
  end
  
  get '/users/:id/movies', to: 'movies#index', as: 'movies'

  resources :users, only: :show

  resources :viewing_party
end

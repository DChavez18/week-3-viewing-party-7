Rails.application.routes.draw do
  root 'welcome#index'

  get '/login', to: "users#login_form"
  post '/login', to: "users#login"
  get '/register', to: 'users#new'
  post '/users', to: 'users#create'
  get '/users/:id/movies', to: 'movies#index', as: 'movies'
  get '/users/:user_id/movies/:id', to: 'movies#show', as: 'movie'

  resources :users, only: :show
end

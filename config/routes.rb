Rails.application.routes.draw do
  # resources :articles, only: [:show] # This will only enable the show route among all the others request
  resources :articles
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "pages#home"
  get "about", to: "pages#about"

end

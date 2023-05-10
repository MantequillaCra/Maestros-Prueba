Rails.application.routes.draw do
  get 'search/results'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  root 'home#index'
  resources :articles do
    resources :comments
  end

  resources :teachers do
    resources :teacher_comments
  end

  get 'search', to:"search#results"

  get 'user/:id', to: "profiles#show"
end

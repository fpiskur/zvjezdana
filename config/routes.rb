Rails.application.routes.draw do
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :clients
  resources :treatments, only: [:create, :edit, :update, :destroy]
  root 'clients#index'
end

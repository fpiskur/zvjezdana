Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :clients
  resources :treatments, only: [:create, :edit, :destroy]
  root 'clients#index'
end

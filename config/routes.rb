Rails.application.routes.draw do
  resources :clients
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'clients#index'
end

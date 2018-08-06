Rails.application.routes.draw do
  root "static_pages#home"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  get "signup", to: "users#new"
  post "signup", to: "users#create"
  resources :password_resets, except: %i(index show destroy)
  resources :users, except: %i(index destroy)
  resources :account_activations, only: :edit
  resources :categories, only: :show
  namespace :admin do
    resources :users, only: %i(index update destroy)
    resources :categories, except: :show
    resources :images, only: %i(index destroy)
    resources :rooms, except: %i(new create)
  end
end

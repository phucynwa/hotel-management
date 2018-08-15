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
  resources :rooms, only: %i(index show)
  resources :images, only: :index
  resources :ratings, except: %i(show update index)
  resources :requests, except: %i(index destroy)
  resources :bookings, except: %i(index destroy show)
  namespace :admin do
    resources :users, only: %i(index update destroy)
    resources :categories, except: :show
    resources :images, only: %i(index destroy)
    resources :rooms, except: :show
    resources :bookings, except: %i(new create destroy)
    resources :notifications, except: :show
    resources :ratings, only: :index
    resources :requests, only: :index
  end
end

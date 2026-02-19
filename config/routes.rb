Rails.application.routes.draw do
  devise_for :users

  # Page d'accueil
  root 'movies#index'

  # Films
  resources :movies, only: [:index, :show] do
    collection do
      get :search
    end
  end

  # Wishlist
  resources :wishlists, only: [:index, :create, :update, :destroy]
  # Cinémas
  resources :cinemas, only: [:index, :show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end

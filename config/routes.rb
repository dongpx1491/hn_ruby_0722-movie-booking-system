require "sidekiq/web"
Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  scope "(:locale)", locale: /en|vi/ do
    namespace :admin do
      root "static_pages#home"
      get "/home", to: "admin#home"
      resources :genres
      resources :movies
      resources :shows
      resources :payments
      resources :users, only: %i(index show)
    end
    root "static_pages#home"
    devise_for :users, skip: :omniauth_callbacks
    get "/movies", to: "movies#sort"
    get "/activation", to: "payments#activation"
    resources :tickets
    resources :users, except: :index
    resources :genres, only: :show
    resources :payments
    resources :order_historys
    resources :favorites, only: %i(index create destroy)
    resources :ratings, only: :create
    resources :payment_activations, only: :edit
    resources :movies, only: %i(index show) do
      resources :shows
    end
    mount Sidekiq::Web => "/sidekiq"
  end
end

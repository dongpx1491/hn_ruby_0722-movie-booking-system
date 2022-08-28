Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    namespace :admin do
      root "static_pages#home"
      get "/home", to: "admin#home"
      resources :genres
      resources :movies
      resources :shows
    end
    root "static_pages#home"
    get "/movies", to: "movies#sort"
    get "/signup", to: "users#new"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "/activation", to: "payments#activation"
    resources :tickets
    resources :users
    resources :genres, only: :show
    resources :payments
    resources :order_historys
    resources :account_activations, only: :edit
    resources :password_resets, except: %i(show destroy index)
    resources :payment_activations, only: :edit
    resources :movies, only: %i(index show) do
      resources :shows
    end
  end
end

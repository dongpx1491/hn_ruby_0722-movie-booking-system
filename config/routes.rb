Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    namespace :admin do
      root "static_pages#home"
      get "/home", to: "admin#home"
      resources :genres
    end
    root "static_pages#home"
    get "/movies", to: "movies#sort"
    get "/signup", to: "users#new"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :tickets
    resources :users
    resources :movies, only: %i(index show) do
      resources :shows
    end
  end
end

Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "movies#index"
    get "/signup", to: "users#new"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :users
    resources :movies, only: %i(show)
  end
end

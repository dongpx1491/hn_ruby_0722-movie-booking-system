Rails.application.routes.draw do
  get 'static_pages/home'
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "/movies", to: "movies#sort"
    get "/signup", to: "users#new"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :tickets
    resources :users
    resources :movies do
      resources :shows
    end
  end
end

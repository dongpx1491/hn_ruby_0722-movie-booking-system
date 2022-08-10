Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "movies#index"
    get "/signup", to: "users#new"
    resources :users
  end
end

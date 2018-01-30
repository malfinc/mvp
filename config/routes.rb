Rails.application.routes.draw do
  mount JSONAPI::Resources::Home::Engine, at: "/"

  namespace :v1 do
    jsonapi_resources :accounts
    jsonapi_resources :carts
    jsonapi_resources :cart_items
    jsonapi_resources :billing_informations
    jsonapi_resources :shipping_informations
    jsonapi_resources :payments
    jsonapi_resources :products
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

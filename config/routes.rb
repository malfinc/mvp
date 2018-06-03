Rails.application.routes.draw do
  devise_for :accounts

  mount JSONAPI::Home::Engine, at: "/"

  namespace :v1 do
    resources :accounts, only: [:index ,:show ,:create ,:update]
    resources :billing_informations, path: "billing-informations", only: [:index ,:show ,:create ,:update]
    resources :delivery_informations, path: "delivery-informations", only: [:index ,:show ,:create ,:update]
    resources :cart_items, path: "cart-items", only: [:index ,:show ,:create, :destroy]
    resources :carts, only: [:show ,:update]
    resources :products, only: [:index ,:show]
    resources :payments, only: [:index ,:show ,:create]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

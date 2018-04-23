Rails.application.routes.draw do
  devise_for :accounts

  mount JSONAPI::Home::Engine, at: "/"

  namespace :v1 do
    resources :accounts
    resources :billing_informations, path: "billing-informations"
    resources :shipping_informations, path: "shipping-informations"
    resources :cart_items, path: "cart-items"
    resources :carts
    resources :products
    resources :payments
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

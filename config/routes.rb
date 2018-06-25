Rails.application.routes.draw do
  devise_for :accounts

  authenticate :account, -> (account) {account.administrator?} do
    mount Sidekiq::Web => "/admin/workers"
  end

  resources :recipes
  resources :menu_items
  resources :establishments
  resources :submissions

  namespace :admin do
    resources :accounts
    resources :recipes
    resources :menu_items
    resources :establishments
    resources :payment_types
    resources :diets
    resources :allergies
    namespace :friendly_id do
      resources :slugs
    end
    namespace :paper_trail do
      resources :versions
    end
    namespace :gutentag do
      resources :tags
      resources :taggings
    end

    root :to => "accounts#index"
  end

  get "/pages/*id" => "pages#show", :as => :page, :format => false

  root :to => "pages#show", :id => "landing"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

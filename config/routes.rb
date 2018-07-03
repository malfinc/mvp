Rails.application.routes.draw do
  devise_for :accounts, :controllers => {
    :confirmations => "accounts/confirmations"
  }

  devise_scope :account do
    namespace :accounts do
      resources :confirmations, :only => [:edit, :update, :new, :create]
    end
  end

  authenticate :account, -> (account) {account.administrator?} do
    mount Sidekiq::Web => "/admin/workers"
  end

  resources :recipes
  resources :menu_items
  resources :establishments
  resources :establishment_searches, :only => [:new, :create, :show]
  resources :submissions

  namespace :admin do
    resources :accounts
    resources :recipes
    resources :menu_items
    resources :establishments
    resources :payment_types
    resources :diets
    resources :allergies
    resources :versions
    namespace :friendly_id do
      resources :slugs
    end
    namespace :gutentag do
      resources :tags
      resources :taggings
    end

    root :to => "accounts#index"
  end

  get "/frontpage" => "pages#show", :as => :frontpage, :format => false, :id => "frontpage"
  get "/pages/*id" => "pages#show", :as => :page, :format => false

  root :to => "pages#show", :id => "landing"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

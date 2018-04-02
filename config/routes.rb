Rails.application.routes.draw do
  authenticate :account, -> (account) { account.administrator?} do
    mount Sidekiq::Web => '/admin/workers'
  end

  resources :recipes
  devise_for :accounts

  namespace :admin do
    resources :accounts
    resources :recipes
    namespace :friendly_id do
      resources :slugs
    end
    namespace :gutentag do
      resources :tags
      resources :taggings
    end

    root to: "accounts#index"
  end

  get "/pages/*id" => "pages#show", as: :page, format: false

  root to: "pages#show", id: "landing"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

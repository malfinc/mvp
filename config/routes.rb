Rails.application.routes.draw do
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

  resources :recipes
  devise_for :accounts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

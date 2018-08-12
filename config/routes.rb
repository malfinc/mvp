Rails.application.routes.draw do
  devise_for(:accounts)

  mount(JSONAPI::Home::Engine, :at => "/")

  namespace(:v1) do
    resources(:accounts, :only => [:index, :show, :create, :update, :destroy])
    resources(:payments, :only => [:index, :show, :create])
    resources(:sessions, :only => [:create, :destroy])
    resources(:tags, :only => [:index, :show])
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

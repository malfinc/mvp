Rails.application.routes.draw do
  devise_for(:accounts)

  namespace(:v1) do
    resources(:accounts, :only => [:index, :show, :create, :update, :destroy])
    resources(:payment_types, :only => [:index, :show])
    resources(:payments, :only => [:index, :show, :create])
    resources(:searches, :only => [:show, :create])
    resources(:sessions, :only => [:create, :destroy])
    resources(:tags, :only => [:index, :show])
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

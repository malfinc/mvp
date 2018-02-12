module V1
  class BillingInformationsController < ::V1::ApplicationController
    before_action :ensure_account_exists, on: :create
    before_action :ensure_cart_exists, on: :create
    before_action :authenticate_account!
  end
end

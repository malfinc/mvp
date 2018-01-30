module V1
  class CartItemsController < ::V1::ApplicationController
    before_action :ensure_account_exists
    before_action :ensure_cart_exists
    before_action :authenticate_account!

    private def ensure_account_exists
      binding.pry
      unless signed_in?
        sign_in(Guest.new)
      end
    end
  end
end

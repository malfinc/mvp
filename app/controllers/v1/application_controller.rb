module V1
  class ApplicationController < ::ApplicationController
    include JSONAPI::ActsAsResourceController

    def cart_is_fresh?
      current_cart.present? && current_cart.fresh?
    end

    def cart_loaded_up?
      current_cart.present?
    end

    def current_cart
      @current_cart ||= current_account.fresh_cart if account_signed_in?
    end

    def context
      {
        current_cart: if cart_loaded_up? then current_cart end,
        current_account: if account_signed_in? then current_account end
      }
    end
  end
end

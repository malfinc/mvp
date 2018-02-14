module V1
  class ApplicationController < ::ApplicationController
    # include JSONAPI::ActsAsResourceController

    private def serialize(payload)
      JSONAPI::Serializer.serialize(payload.as_serialize)
    end

    def deserialize
      JSONAPI::
    end

    private def ensure_account_exists
      unless account_signed_in?
        sign_in(Account.create!)
      end
    end

    private def ensure_cart_exists
      cart_loaded_up?
    end

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

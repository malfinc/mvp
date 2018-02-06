module V1
  class CartItemsController < ::V1::ApplicationController
    before_action :ensure_account_exists, on: :create
    before_action :ensure_cart_exists, on: :create
    before_action :authenticate_account!

    private def ensure_account_exists
      unless account_signed_in?
        sign_in(Account.create!(id: session["guest_id"]))
        session["guest_id"] ||= current_account.id
      end
    end

    private def ensure_cart_exists
      cart_loaded_up?
    end
  end
end

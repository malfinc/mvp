module V1
  class CartItemResource < ::V1::ApplicationResource
    record_context :current_account
    record_context :current_cart

    has_one :account
    has_one :cart
    has_one :product

    monetize :price
  end
end

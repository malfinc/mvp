module V1
  class CartItemResource < ::V1::ApplicationResource
    has_one :account
    has_one :cart
    has_one :product

    monetize :price
  end
end

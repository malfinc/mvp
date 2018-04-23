module V1
  class CartItemSerializer < ApplicationSerializer
    has_one :account, include_data: true
    has_one :cart, include_data: true
    has_one :product, include_data: true

    attribute :price_cents
    attribute :price_currency
    attribute :price
  end
end

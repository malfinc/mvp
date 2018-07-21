module V1
  class CartItemSerializer < ApplicationSerializer
    has_one(:account, :include_data => true)
    has_one(:cart, :include_data => true)
    has_one(:product, :include_data => true)

    attribute(:price) do
      object.price&.format
    end
    attribute(:price_cents)
    attribute(:price_currency)
  end
end

module V1
  class ProductSerializer < ApplicationSerializer
    has_many(:cart_items, :include_data => true)

    attribute(:price) do
      object.price&.format
    end
    attribute(:price_cents)
    attribute(:price_currency)
  end
end

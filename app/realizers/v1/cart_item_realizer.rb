module V1
  class CartItemRealizer
    include JSONAPI::Realizer::Resource

    register :cart_items, class_name: "CartItem", adapter: :active_record

    has_one :account, as: :accounts
    has_one :cart, as: :carts
    has_one :product, as: :products

    has :price_cents
    has :price_currency
    has :price
  end
end

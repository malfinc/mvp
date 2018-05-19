module V1
  class CartRealizer
    include JSONAPI::Realizer::Resource

    register :carts, class_name: "Cart", adapter: :active_record

    has_one :account, as: :accounts
    has_one :billing_information, as: :billing_informations
    has_one :delivery_information, as: :delivery_informations
    has_many :payments, as: :payments
    has_many :cart_items, as: :cart_items

    has :total_cents
    has :total_currency
    has :total
    has :subtotal_cents
    has :subtotal_currency
    has :subtotal
    has :discount_cents
    has :discount_currency
    has :discount
    has :tax_cents
    has :tax_currency
    has :tax
    has :shipping_cents
    has :shipping_currency
    has :shipping
    has :checkout_state_event, selectable: false
  end
end

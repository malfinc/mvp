module V1
  class PaymentRealizer
    include JSONAPI::Realizer::Resource

    register :payments, class_name: "Payment", adapter: :active_record

    has_one :account, as: :accounts
    has_one :cart, as: :carts

    has :subtype
    has :service_eid
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
  end
end

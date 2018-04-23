module V1
  class PaymentSerializer < ApplicationSerializer
    has_one :account, include_data: true
    has_one :cart, include_data: true

    attribute :subtype
    attribute :service_eid
    attribute :total_cents
    attribute :total_currency
    attribute :total
    attribute :subtotal_cents
    attribute :subtotal_currency
    attribute :subtotal
    attribute :discount_cents
    attribute :discount_currency
    attribute :discount
    attribute :tax_cents
    attribute :tax_currency
    attribute :tax
    attribute :shipping_cents
    attribute :shipping_currency
    attribute :shipping
  end
end

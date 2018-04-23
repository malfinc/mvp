module V1
  class CartSerializer < ApplicationSerializer
    has_one :account, include_data: true
    has_one :billing_information, include_data: true
    has_one :shipping_information, include_data: true
    has_one :payment, include_data: true
    has_many :cart_items, include_data: true

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

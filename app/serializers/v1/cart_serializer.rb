module V1
  class CartSerializer < ApplicationSerializer
    has_one :account, include_data: true
    has_one :billing_information, include_data: true
    has_one :delivery_information, include_data: true
    has_many :payments, include_data: true
    has_many :cart_items, include_data: true

    attribute :subtotal do
      object.subtotal.try!(:format)
    end
    attribute :subtotal_cents
    attribute :subtotal_currency
    attribute :discount do
      object.discount.try!(:format)
    end
    attribute :discount_cents
    attribute :discount_currency
    attribute :tax do
      object.tax.try!(:format)
    end
    attribute :tax_cents
    attribute :tax_currency
    attribute :shipping do
      object.shipping.try!(:format)
    end
    attribute :shipping_cents
    attribute :shipping_currency
    attribute :total do
      object.total.try!(:format)
    end
    attribute :total_cents
    attribute :total_currency
  end
end

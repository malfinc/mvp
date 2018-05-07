module V1
  class PaymentSerializer < ApplicationSerializer
    has_one :account, include_data: true
    has_one :cart, include_data: true

    attribute :subtype
    attribute :source_id
    attribute :paid_cents
    attribute :paid_currency
    attribute :paid
    attribute :restitution_cents
    attribute :restitution_currency
    attribute :restitution
  end
end

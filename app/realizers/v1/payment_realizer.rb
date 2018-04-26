module V1
  class PaymentRealizer
    include JSONAPI::Realizer::Resource

    register :payments, class_name: "Payment", adapter: :active_record

    has_one :account, as: :accounts
    has_one :cart, as: :carts

    has :subtype
    has :source_id
    has :paid_cents
    has :paid_currency
    has :paid
    has :refund_cents
    has :refund_currency
    has :refund
    has :processing_state_event
  end
end

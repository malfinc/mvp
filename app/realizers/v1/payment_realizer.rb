module V1
  class PaymentRealizer
    include(JSONAPI::Realizer::Resource)

    register(:payments, :class_name => "Payment", :adapter => :active_record)

    has_one(:account, :as => :accounts)

    has(:subtype)
    has(:source_id)
    has(:paid_cents)
    has(:paid_currency)
    has(:paid)
    has(:restitution_cents)
    has(:restitution_currency)
    has(:restitution)
    has(:processing_state_event)
  end
end

module V1
  class PaymentRealizer < ApplicationRealizer
    type(:payments, :class_name => "Payment", :adapter => :active_record)

    has(:subtype)
    has(:source_id)
    has(:paid)
    has(:paid_cents)
    has(:paid_currency)
    has(:restitution)
    has(:restitution_cents)
    has(:restitution_currency)
    has(:processing_state_event)

    has_one(:account, :class_name => "Account")
    has_one(:cart, :class_name => "Cart")
  end
end

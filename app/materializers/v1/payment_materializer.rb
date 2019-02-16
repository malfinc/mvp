module V1
  class PaymentMaterializer < ::V1::ApplicationMaterializer
    type(:payments)

    has(:subtype)
    has(:source_id)
    has(:paid)
    has(:paid_cents)
    has(:paid_currency)
    has(:restitution)
    has(:restitution_cents)
    has(:restitution_currency)
    has(:processing_state)

    has_one(:account, :class_name => "Account")
    has_one(:cart, :class_name => "Cart")
  end
end

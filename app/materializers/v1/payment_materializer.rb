module V1
  class PaymentMaterializer < ::V1::ApplicationMaterializer
    type(:payments)

    has(:subtype, :visible => :readable_attribute?)
    has(:source_id, :visible => :readable_attribute?)
    has(:paid, :visible => :readable_attribute?)
    has(:paid_cents, :visible => :readable_attribute?)
    has(:paid_currency, :visible => :readable_attribute?)
    has(:restitution, :visible => :readable_attribute?)
    has(:restitution_cents, :visible => :readable_attribute?)
    has(:restitution_currency, :visible => :readable_attribute?)
    has(:processing_state, :visible => :readable_attribute?)

    has_one(:account, :class_name => "Account", :visible => :readable_relationship?)
    has_one(:cart, :class_name => "Cart", :visible => :readable_relationship?)
  end
end

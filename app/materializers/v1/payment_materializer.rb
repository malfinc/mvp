module V1
  class PaymentMaterializer < ::V1::ApplicationMaterializer
    type(:payments)

    has(:subtype, :visible => :readable?)
    has(:source_id, :visible => :readable?)
    has(:paid, :visible => :readable?)
    has(:paid_cents, :visible => :readable?)
    has(:paid_currency, :visible => :readable?)
    has(:restitution, :visible => :readable?)
    has(:restitution_cents, :visible => :readable?)
    has(:restitution_currency, :visible => :readable?)
    has(:processing_state, :visible => :readable?)

    has_one(:account, :class_name => "Account", :visible => :readable_relationship?)
    has_one(:cart, :class_name => "Cart", :visible => :readable_relationship?)
  end
end

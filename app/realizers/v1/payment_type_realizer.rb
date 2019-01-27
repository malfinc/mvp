module V1
  class PaymentTypeRealizer < ApplicationRealizer
    type(:payment_types, :class_name => "PaymentType", :adapter => :active_record)

    has(:email)
  end
end

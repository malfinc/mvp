module V1
  class PaymentTypeMaterializer < ::V1::ApplicationMaterializer
    type(:payment_types)

    has(:email)
  end
end

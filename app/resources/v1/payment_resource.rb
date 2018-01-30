module V1
  class PaymentResource < ::V1::ApplicationResource
    has_one :account
    has_one :cart
  end
end

module V1
  class PaymentResource < ::V1::ApplicationResource
    record_context :current_account
    record_context :current_cart

    has_one :account
    has_one :cart, foreign_key_on: :related

    attribute :subtype
    attribute :service_eid
  end
end

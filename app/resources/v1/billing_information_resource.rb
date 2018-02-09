module V1
  class BillingInformationResource < ::V1::ApplicationResource
    record_context :current_account
    record_context :current_cart

    has_one :account
    has_one :cart
  end
end

module V1
  class BillingInformationResource < ::V1::ApplicationResource
    has_one :account
    has_one :cart
  end
end

module V1
  class ShippingInformationResource < ::V1::ApplicationResource
    record_context :current_account
    record_context :current_cart

    has_one :account
    has_one :cart
  end
end

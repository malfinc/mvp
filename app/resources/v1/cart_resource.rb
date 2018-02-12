module V1
  class CartResource < ::V1::ApplicationResource
    has_one :account
    has_one :billing_information
    has_one :shipping_information
    has_one :payment
    has_many :cart_items, always_include_linkage_data: true
  end
end

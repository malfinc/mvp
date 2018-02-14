module V1
  class AccountResource < ::V1::ApplicationResource
    has_many :carts, always_include_linkage_data: true
    has_many :billing_informations, always_include_linkage_data: true
    has_many :shipping_informations, always_include_linkage_data: true
    has_many :payments, always_include_linkage_data: true

    attribute :email
  end
end

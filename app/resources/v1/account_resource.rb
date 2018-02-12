module V1
  class AccountResource < ::V1::ApplicationResource
    record_context :current_account
    record_context :current_cart

    has_many :carts, always_include_linkage_data: true
    has_one :current_cart, class_name: "Cart", foreign_key_on: :related
    has_many :billing_informations, always_include_linkage_data: true
    has_many :shipping_informations, always_include_linkage_data: true
    has_many :payments, always_include_linkage_data: true

    attribute :email
  end
end

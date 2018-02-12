module V1
  class ShippingInformationResource < ::V1::ApplicationResource
    record_context :current_account
    record_context :current_cart

    has_one :account
    has_many :carts, always_include_linkage_data: true

    attribute :name
    attribute :address
    attribute :city
    attribute :state
    attribute :postal
  end
end

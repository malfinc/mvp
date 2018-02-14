module V1
  class BillingInformationResource < ::V1::ApplicationResource
    has_one :account
    has_many :carts, always_include_linkage_data: true

    attribute :name
    attribute :address
    attribute :city
    attribute :state
    attribute :postal
  end
end

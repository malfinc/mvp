module V1
  class DeliveryInformationSerializer < ApplicationSerializer
    has_one :account, include_data: true
    has_many :carts, include_data: true

    attribute :name
    attribute :address
    attribute :city
    attribute :state
    attribute :postal
  end
end

module V1
  class AccountSerializer < ApplicationSerializer

    has_many :carts, include_data: true
    has_many :billing_informations, include_data: true
    has_many :delivery_informations, include_data: true
    has_many :payments, include_data: true

    attribute :email
    attribute :unconfirmed_email
  end
end

module V1
  class AccountSerializer < ApplicationSerializer
    has_many(:carts, :include_data => true, &policy_scoped(:payments))
    has_many(:billing_informations, :include_data => true, &policy_scoped(:payments))
    has_many(:delivery_informations, :include_data => true, &policy_scoped(:payments))
    has_many(:payments, :include_data => true, &policy_scoped(:payments))

    attribute(:email)
    attribute(:authentication_secret, if: policy_allows_attribute?(:authentication_secret))
    attribute(:unconfirmed_email)
  end
end

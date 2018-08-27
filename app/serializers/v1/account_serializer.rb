module V1
  class AccountSerializer < ApplicationSerializer
    has_many(:payments)

    attribute(:name)
    attribute(:username)
    attribute(:email)
    attribute(:authentication_secret)
    attribute(:unconfirmed_email)
  end
end

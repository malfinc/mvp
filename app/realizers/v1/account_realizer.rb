module V1
  class AccountRealizer < ApplicationRealizer
    type(:accounts, :class_name => "Account", :adapter => :active_record)

    has_many(:payments, :as => :payments, :class_name => "PaymentRealizer")

    has(:email)
    has(:name)
    has(:username)
    has(:password)
  end
end

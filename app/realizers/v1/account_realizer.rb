module V1
  class AccountRealizer
    include JSONAPI::Realizer::Resource
    include Pundit

    register :accounts, class_name: "Account", adapter: :active_record

    has_many :carts, as: :carts
    has_many :billing_informations, as: :billing_informations
    has_many :delivery_informations, as: :delivery_informations
    has_many :payments, as: :payments

    has :email
  end
end

module V1
  class BillingInformationRealizer
    include(JSONAPI::Realizer::Resource)

    register(:billing_informations, :class_name => "BillingInformation", :adapter => :active_record)

    has_one(:account, :as => :accounts)
    has_many(:carts, :as => :carts)

    has(:name)
    has(:address)
    has(:city)
    has(:state)
    has(:postal)
  end
end

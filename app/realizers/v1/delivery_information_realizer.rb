module V1
  class DeliveryInformationRealizer
    include(JSONAPI::Realizer::Resource)

    register(:delivery_informations, :class_name => "DeliveryInformation", :adapter => :active_record)

    has_one(:account, :as => :accounts)
    has_many(:carts, :as => :carts)

    has(:name)
    has(:address)
    has(:city)
    has(:state)
    has(:postal)
  end
end

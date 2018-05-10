module V1
  class ShippingInformationRealizer
    include JSONAPI::Realizer::Resource

    register :shipping_informations, class_name: "ShippingInformation", adapter: :active_record

    has_one :account, as: :accounts
    has_many :carts, as: :carts

    has :name
    has :address
    has :city
    has :state
    has :postal
  end
end

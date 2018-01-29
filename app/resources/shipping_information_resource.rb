class ShippingInformationResource < JSONAPI::Resource
  has_one :account
  has_one :cart
end

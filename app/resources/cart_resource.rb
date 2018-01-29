class CartResource < JSONAPI::Resource
  has_one :account
  has_one :billing_information
  has_one :shipping_information
  has_one :payment
end

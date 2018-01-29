class BillingInformationResource < JSONAPI::Resource
  has_one :account
  has_one :cart
end

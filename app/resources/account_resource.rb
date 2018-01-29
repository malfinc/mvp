class AccountResource < JSONAPI::Resource
  has_many :carts
  has_one :current_cart
  has_many :billing_informations
  has_many :shipping_informations
  has_many :payments
end

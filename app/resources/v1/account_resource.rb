module V1
  class AccountResource < ::V1::ApplicationResource
    has_many :carts
    has_one :current_cart, class_name: "Cart"
    has_many :billing_informations
    has_many :shipping_informations
    has_many :payments
  end
end

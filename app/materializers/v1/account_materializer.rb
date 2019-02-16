module V1
  class AccountMaterializer < ::V1::ApplicationMaterializer
    type(:accounts)

    has(:email)
    has(:name)
    has(:username)
    has(:created_at)
    has(:updated_at)

    has_many(:carts, :class_name => "Cart")
    has_many(:payments, :class_name => "Payment")
  end
end

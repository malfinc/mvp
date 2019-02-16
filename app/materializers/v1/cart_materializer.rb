module V1
  class CartMaterializer < ::V1::ApplicationMaterializer
    type(:carts)

    has(:email)
  end
end

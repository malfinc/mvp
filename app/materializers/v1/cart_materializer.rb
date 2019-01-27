module V1
  class CartMaterializer < ::V1::ApplicationMaterializer
    type(:carts)

    has(:email, :visible => :readable_attribute?)
  end
end

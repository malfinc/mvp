module V1
  class CartItemsController < ::V1::ApplicationController
    discoverable(
      version: "v1",
      namespace: "cart-items"
    )

    def index
      authenticate_account!

      realization = JSONAPI::Realizer.index(
        CartItemsIndexSchema.new(request.parameters).as_json,
        headers: request.headers,
        scope: policy_scope(CartItem),
        type: :cart_items
      )

      authorize policy_scope(CartItem)

      render json: serialize(realization)
    end

    def show
      authenticate_account!

      realization = JSONAPI::Realizer.show(
        CartItemsShowSchema.new(request.parameters).as_json,
        headers: request.headers,
        scope: policy_scope(CartItem),
        type: :cart_items
      )

      authorize realization.model

      render json: serialize(realization)
    end

    def create
      ensure_account_exists
      authenticate_account!
      ensure_cart_exists

      realization = JSONAPI::Realizer.create(
        CartItemsCreateSchema.new(request.parameters).as_json,
        scope: policy_scope(CartItem),
        headers: request.headers,
      )

      authorize realization.model

      AddToCartOperation.(cart_item: realization.model)

      render json: serialize(realization), status: :created
    end
  end
end

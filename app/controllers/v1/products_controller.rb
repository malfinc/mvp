module V1
  class ProductsController < ::V1::ApplicationController
    discoverable(
      version: "v1",
      namespace: "products"
    )

    def index
      realization = JSONAPI::Realizer.index(
        ProductsIndexSchema.new(request.parameters).as_json || {},
        headers: request.headers,
        scope: policy_scope(Product),
        type: :products
      )

      authorize policy_scope(Product)

      render json: serialize(realization)
    end

    def show
      realization = JSONAPI::Realizer.show(
        ProductsShowSchema.new(request.parameters).as_json || {},
        headers: request.headers,
        scope: policy_scope(Product),
        type: :products
      )

      authorize realization.model

      render json: serialize(realization)
    end
  end
end

module V1
  class CartsController < ::V1::ApplicationController
    discoverable(
      version: "v1",
      namespace: "carts"
    )

    def show
      realization = JSONAPI::Realizer.show(
        CartsShowSchema.new(request.parameters).as_json,
        headers: request.headers,
        scope: policy_scope(Cart),
        type: :carts
      )

      authorize realization.model

      render json: serialize(realizer.model)
    end
  end
end

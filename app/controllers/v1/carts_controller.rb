module V1
  class CartsController < ::V1::ApplicationController
    discoverable(
      version: "v1",
      namespace: "carts"
    )

    def show
      realization = JSONAPI::Realizer.show(
        CartsShowSchema.new(modified_parameters).as_json,
        headers: request.headers,
        scope: policy_scope(Cart),
        type: :carts
      )

      authorize realization.model

      render json: serialize(realization)
    end

    def update
      realization = JSONAPI::Realizer.update(
        CartsUpdateSchema.new(modified_parameters).as_json,
        headers: request.headers,
        scope: policy_scope(Cart)
      )

      authorize realization.model

      realization.model.save!

      render json: serialize(realization)
    end

    private def modified_parameters
      upsert_parameter(
        {
          ["id"] => {"mine" => current_cart.id},
          ["data", "id"] => {"mine" => current_cart.id},
          ["data", "relationships", "billing-information", "data", "id"] => {
            "current" => current_cart.billing_information_id
          },
          ["data", "relationships", "delivery-information", "data", "id"] => {
            "current" => current_cart.delivery_information_id
          },
        },
        request.parameters
      )
    end
  end
end

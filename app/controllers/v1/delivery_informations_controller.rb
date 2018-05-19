module V1
  class DeliveryInformationsController < ::V1::ApplicationController
    discoverable(
      version: "v1",
      namespace: "delivery-informations"
    )

    def index
      realization = JSONAPI::Realizer.index(
        DeliveryInformationsIndexSchema.new(modified_parameters).as_json,
        headers: request.headers,
        scope: policy_scope(DeliveryInformation),
        type: :delivery_information
      )

      authorize policy_scope(DeliveryInformation)

      render json: serialize(realization)
    end

    def show
      realization = JSONAPI::Realizer.show(
        DeliveryInformationsShowSchema.new(modified_parameters).as_json,
        headers: request.headers,
        scope: policy_scope(DeliveryInformation),
        type: :delivery_informations
      )

      authorize realization.model

      render json: serialize(realizer.model)
    end

    def create
      ensure_account_exists
      authenticate_account!
      ensure_cart_exists

      realization = JSONAPI::Realizer.create(
        DeliveryInformationsCreateSchema.new(modified_parameters).as_json,
        scope: policy_scope(DeliveryInformation),
        headers: request.headers,
      )

      authorize realization.model

      realization.model.save!

      render json: serialize(realization), status: :created
    end

    def update
      realization = JSONAPI::Realizer.update(
        DeliveryInformationsUpdateSchema.new(modified_parameters).as_json,
        scope: policy_scope(DeliveryInformation),
        headers: request.headers,
      )

      authorize realization.model

      realization.model.save!

      render json: serialize(realizationmodel)
    end

    private def modified_parameters
      upsert_parameter(
        {
          ["id"] => {"current" => current_cart.delivery_information_id},
          ["data", "id"] => {"current" => current_cart.delivery_information_id}
        },
        request.parameters
      )
    end
  end
end

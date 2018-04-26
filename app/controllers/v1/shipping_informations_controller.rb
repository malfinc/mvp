module V1
  class ShippingInformationsController < ::V1::ApplicationController
    discoverable(
      version: "v1",
      namespace: "shipping-informations"
    )

    before_action :ensure_account_exists, on: :create
    before_action :ensure_cart_exists, on: :create
    before_action :authenticate_account!

    def index
      realization = JSONAPI::Realizer.index(
        ShippingInformationsIndexSchema.new(request.parameters).as_json,
        headers: request.headers,
        scope: policy_scope(ShippingInformation),
        type: :shipping_information
      )

      authorize policy_scope(ShippingInformation)

      render json: serialize(realization)
    end

    def show
      realization = JSONAPI::Realizer.show(
        ShippingInformationsShowSchema.new(request.parameters).as_json,
        headers: request.headers,
        scope: policy_scope(ShippingInformation),
        type: :shipping_informations
      )

      authorize realization.model

      render json: serialize(realizer.model)
    end

    def create

      realization = JSONAPI::Realizer.create(
        ShippingInformationsCreateSchema.new(request.parameters).as_json,
        scope: policy_scope(ShippingInformation),
        headers: request.headers,
      )

      authorize realization.model

      realization.model.save!

      render json: serialize(realization)
    end

    def update
      realization = JSONAPI::Realizer.update(
        ShippingInformationsUpdateSchema.new(request.parameters).as_json,
        scope: policy_scope(ShippingInformation),
        headers: request.headers,
      )

      authorize realization.model

      realization.model.save!

      render json: serialize(realization)
    end
  end
end

module V1
  class BillingInformationsController < ::V1::ApplicationController
    discoverable(
      version: "v1",
      namespace: "billing-informations"
    )
    before_action :ensure_account_exists, on: :create
    before_action :ensure_cart_exists, on: :create
    before_action :authenticate_account!

    def index
      realization = JSONAPI::Realizer.index(
        BillingInformationsIndexSchema.new(request.parameters).as_json,
        headers: request.headers,
        scope: policy_scope(BillingInformation),
        type: :billing_information
      )

      authorize policy_scope(BillingInformation)

      render json: serialize(realization)
    end

    def show
      realization = JSONAPI::Realizer.show(
        BillingInformationsShowSchema.new(request.parameters).as_json,
        headers: request.headers,
        scope: policy_scope(BillingInformation),
        type: :billing_informations
      )

      authorize realization.model

      render json: serialize(realizer.model)
    end

    def create

      realization = JSONAPI::Realizer.create(
        BillingInformationsCreateSchema.new(request.parameters).as_json,
        scope: policy_scope(BillingInformation),
        headers: request.headers,
      )

      realization.model.save!

      authorize realization.model

      render json: serialize(realization)
    end

    def update

      realization = JSONAPI::Realizer.update(
        BillingInformationsUpdateSchema.new(request.parameters).as_json,
        scope: policy_scope(BillingInformation),
        headers: request.headers,
      )

      realization.model.save!

      authorize realization.model

      render json: serialize(realization)
    end
  end
end

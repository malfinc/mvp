module V1
  class PaymentsController < ::V1::ApplicationController
    discoverable(
      version: "v1",
      namespace: "payments"
    )

    before_action :ensure_account_exists, on: :create
    before_action :ensure_cart_exists, on: :create
    before_action :authenticate_account!

    def index
      realization = JSONAPI::Realizer.index(
        PaymentsIndexSchema.new(request.parameters).as_json,
        headers: request.headers,
        scope: policy_scope(Payment),
        type: :payments
      )

      authorize policy_scope(Payment)

      render json: serialize(realization)
    end

    def show
      realization = JSONAPI::Realizer.show(
        PaymentsShowSchema.new(request.parameters).as_json,
        headers: request.headers,
        scope: policy_scope(Payment),
        type: :payments
      )

      authorize realization.model

      render json: serialize(realizer.model)
    end

    def create
      Payment.transaction do
        realization = JSONAPI::Realizer.create(
          PaymentsCreateSchema.new(request.parameters).as_json,
          scope: policy_scope(Payment),
          headers: request.headers,
        )

        authorize realization.model

        realization.model.save!

        render json: serialize(realization)
      end
    end
  end
end

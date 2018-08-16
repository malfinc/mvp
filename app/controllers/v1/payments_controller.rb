module V1
  class PaymentsController < ::V1::ApplicationController
    discoverable(
      :version => "v1",
      :namespace => "payments"
    )

    def index
      authorize(policy_scope(Payment))

      realization = JSONAPI::Realizer.index(
        PaymentsIndexSchema.new(request.parameters),
        :headers => request.headers,
        :scope => policy_scope(Payment),
        :type => :payments
      )

      render(:json => serialize(realization))
    end

    def show
      realization = JSONAPI::Realizer.show(
        PaymentsShowSchema.new(request.parameters),
        :headers => request.headers,
        :scope => policy_scope(Payment),
        :type => :payments
      )

      authorize(realization.model)

      return unless stale?(:etag => realization.model)

      render(:json => serialize(realization))
    end

    def create
      authenticate_account!

      realization = JSONAPI::Realizer.create(
        PaymentsCreateSchema.new(request.parameters),
        :scope => policy_scope(Payment),
        :headers => request.headers
      )

      authorize(realization.model)

      PurchaseCartOperation.(:payments => [realization.model], :cart => current_cart)

      render(:json => serialize(realization), :status => :created)
    end
  end
end

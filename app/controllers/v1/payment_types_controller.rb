module V1
  class PaymentTypesController < ::V1::ApplicationController
    discoverable(
      :version => "v1",
      :namespace => "payment-types"
    )

    def index
      authorize(policy_scope(Diet))

      realization = JSONAPI::Realizer.index(
        PaymentTypes::IndexSchema.new(request.parameters),
        :headers => request.headers,
        :scope => policy_scope(PaymentType),
        :type => :accounts
      )

      render(:json => serialize(realization))
    end

    def show
      realization = JSONAPI::Realizer.show(
        PaymentTypes::ShowSchema.new(request.parameters),
        :headers => request.headers,
        :scope => policy_scope(PaymentType),
        :type => :accounts
      )

      authorize(realization.model)

      return unless stale?(:etag => realization.model)

      render(:json => serialize(realization))
    end
  end
end

module V1
  class PaymentTypesController < ::V1::ApplicationController
    discoverable(
      :version => "v1",
      :namespace => "accounts"
    )

    def index
      authorize(policy_scope(Diet))

      realization = JSONAPI::Realizer.index(
        PaymentTypes::IndexSchema.new(modified_parameters),
        :headers => request.headers,
        :scope => policy_scope(PaymentType),
        :type => :accounts
      )

      render(:json => serialize(realization))
    end

    def show
      realization = JSONAPI::Realizer.show(
        PaymentTypes::ShowSchema.new(modified_parameters),
        :headers => request.headers,
        :scope => policy_scope(PaymentType),
        :type => :accounts
      )

      authorize(realization.model)

      render(:json => serialize(realization))
    end
  end
end

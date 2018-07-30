module V1
  class BillingInformationsController < ::V1::ApplicationController
    discoverable(
      :version => "v1",
      :namespace => "billing-informations"
    )

    def index
      authorize(policy_scope(BillingInformation))

      realization = JSONAPI::Realizer.index(
        BillingInformationsIndexSchema.new(modified_parameters).as_json || {},
        :headers => request.headers,
        :scope => policy_scope(BillingInformation),
        :type => :billing_information
      )

      render(:json => serialize(realization))
    end

    def show
      realization = JSONAPI::Realizer.show(
        BillingInformationsShowSchema.new(modified_parameters).as_json || {},
        :headers => request.headers,
        :scope => policy_scope(BillingInformation),
        :type => :billing_informations
      )

      authorize(realization.model)

      render(:json => serialize(realization))
    end

    def create
      authenticate_account!

      realization = JSONAPI::Realizer.create(
        BillingInformationsCreateSchema.new(modified_parameters).as_json || {},
        :scope => policy_scope(BillingInformation),
        :headers => request.headers
      )

      realization.model.save!

      authorize(realization.model)

      render(:json => serialize(realization), :status => :created)
    end

    def update
      authenticate_account!

      realization = JSONAPI::Realizer.update(
        BillingInformationsUpdateSchema.new(modified_parameters).as_json || {},
        :scope => policy_scope(BillingInformation),
        :headers => request.headers
      )

      realization.model.save!

      authorize(realization.model)

      render(:json => serialize(realization))
    end

    private def modified_parameters
      upsert_parameter(
        {
          ["id"] => {"current" => current_cart.billing_information_id},
          ["data", "id"] => {"current" => current_cart.billing_information_id}
        },
        request.parameters
      )
    end
  end
end

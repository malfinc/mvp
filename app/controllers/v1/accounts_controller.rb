module V1
  class AccountsController < ::V1::ApplicationController
    skip_before_action :ensure_account_exists, only: :create

    discoverable(
      version: "v1",
      namespace: "accounts"
    )

    def index
      realization = JSONAPI::Realizer.index(
        AccountsIndexSchema.new(request.parameters).as_json || {},
        headers: request.headers,
        scope: policy_scope(Account),
        type: :accounts
      )

      authorize policy_scope(Account)

      render json: serialize(realization)
    end

    def show
      realization = JSONAPI::Realizer.show(
        AccountsShowSchema.new(modified_parameters).as_json || {},
        headers: request.headers,
        scope: policy_scope(Account),
        type: :accounts
      )

      authorize realization.model

      render json: serialize(realization)
    end

    def create
      realization = JSONAPI::Realizer.create(
        AccountsCreateSchema.new(modified_parameters).as_json || {},
        scope: policy_scope(Account),
        headers: request.headers,
      )

      authorize realization.model

      realization.model.save!

      render json: serialize(realization), status: :created
    end

    def update
      realization = JSONAPI::Realizer.update(
        AccountsUpdateSchema.new(modified_parameters).as_json || {},
        scope: policy_scope(Account),
        headers: request.headers,
      )

      authorize realization.model

      realization.model.save!

      render json: serialize(realization)
    end

    private def modified_parameters
      upsert_parameter(
        {
          ["id"] => {"me" => current_account.id},
          ["data", "id"] => {"me" => current_account.id}
        },
        request.parameters
      )
    end
  end
end

module V1
  class AccountsController < ::V1::ApplicationController
    discoverable(
      version: "v1",
      namespace: "accounts"
    )

    def index
      realization = JSONAPI::Realizer.index(
        AccountsIndexSchema.new(request.parameters).as_json,
        headers: request.headers,
        scope: policy_scope(Account),
        type: :accounts
      )

      authorize policy_scope(Account)

      render json: serialize(realization)
    end

    def show
      realization = JSONAPI::Realizer.show(
        AccountsShowSchema.new(merge_myself(request.parameters)).as_json,
        headers: request.headers,
        scope: policy_scope(Account),
        type: :accounts
      )

      authorize realization.model

      render json: serialize(realizer.model)
    end

    def create
      realization = JSONAPI::Realizer.create(
        AccountsCreateSchema.new(merge_myself(request.parameters)).as_json,
        scope: policy_scope(Account),
        headers: request.headers,
      )

      authorize realization.model

      Account.transaction do
        realization.model.save!

        render json: serialize(realization)
      end
    end

    def update
      realization = JSONAPI::Realizer.update(
        AccountsUpdateSchema.new(merge_myself(request.parameters)).as_json,
        scope: policy_scope(Account),
        headers: request.headers,
      )

      authorize realization.model

      Account.transaction do
        realization.model.save!
        binding.pry

        render json: serialize(realization)
      end
    end

    private def merge_myself(parameters)
      parameters.deep_merge({
        "id" => replacing_myself(["id"], parameters),
        "data" => {
          "id" => replacing_myself(["data", "id"], parameters),
        },
      })
    end
  end
end

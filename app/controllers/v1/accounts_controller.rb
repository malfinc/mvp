module V1
  class AccountsController < ::V1::ApplicationController
    MODEL = ::Account
    REALIZER = ::V1::AccountRealizer
    MATERIALIZER = ::V1::AccountMaterializer
    POLICY = AccountPolicy

    def index
      render(
        :json => inline_jsonapi(
          :schema => ::V1::Accounts::IndexSchema,
          :parameters => modified_parameters,
        ),
        :status => :ok,
      )
    end

    def show
      render(
        :json => inline_jsonapi(
          :schema => ::V1::Accounts::ShowSchema,
          :parameters => modified_parameters,
        ),
        :status => :ok,
      )
    end

    def create
      render(
        :json => inline_jsonapi(
          :schema => ::V1::Accounts::CreateSchema,
          :parameters => modified_parameters,
        ) {|model| model.save! && sign_in(model)},
        :status => :created,
      )
    end

    def update
      render(
        :json => inline_jsonapi(
          :schema => ::V1::Accounts::UpdateSchema,
          :parameters => modified_parameters,
        ) {|model| model.save! && sign_in(model)},
        :status => :ok,
      )
    end

    private def modified_parameters
      upsert_parameter(
        {
          ["id"] => {"me" => if account_signed_in? then current_account.id end},
          ["data", "id"] => {"me" => if account_signed_in? then current_account.id end},
        },
        request.parameters,
      )
    end
  end
end

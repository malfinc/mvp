module V1
  class AccountsController < ::V1::ApplicationController
    discoverable(
      :version => "v1",
      :namespace => "accounts"
    )

    def index
      authorize(policy_scope(Account))

      realization = JSONAPI::Realizer.index(
        Accounts::IndexSchema.new(modified_parameters),
        :headers => request.headers,
        :scope => policy_scope(Account),
        :type => :accounts
      )

      render(:json => serialize(realization))
    end

    def show
      realization = JSONAPI::Realizer.show(
        Accounts::ShowSchema.new(modified_parameters),
        :headers => request.headers,
        :scope => policy_scope(Account),
        :type => :accounts
      )

      authorize(realization.model)

      return unless stale?(:etag => realization.model)

      render(:json => serialize(realization))
    end

    def create
      realization = JSONAPI::Realizer.create(
        Accounts::CreateSchema.new(request.parameters),
        :scope => policy_scope(Account),
        :headers => request.headers
      )

      authorize(realization.model)

      realization.model.save!

      sign_in(realization.model)

      render(:json => serialize(realization), :status => :created)
    end

    def update
      realization = JSONAPI::Realizer.update(
        Accounts::UpdateSchema.new(modified_parameters),
        :scope => policy_scope(Account),
        :headers => request.headers
      )

      authorize(realization.model)

      realization.model.save!

      render(:json => serialize(realization))
    end

    private def modified_parameters
      upsert_parameter(
        {
          ["id"] => {"me" => if account_signed_in? then current_account.id end},
          ["data", "id"] => {"me" => if account_signed_in? then current_account.id end}
        },
        request.parameters
      )
    end
  end
end

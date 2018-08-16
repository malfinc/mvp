module V1
  class SessionsController < ::V1::ApplicationController
    discoverable(
      :version => "v1",
      :namespace => "sessions"
    )

    def create
      parameters = Sessions::CreateSchema.new(request.parameters)

      operation = LoginAccountOperation.(
        :scope => policy_scope(Account, :policy_scope_class => SessionPolicy::Scope),
        :shared => parameters.data.attributes.email,
        :secret => parameters.data.attributes.password
      )

      authorize(operation.fetch(:account))

      sign_in("account", operation.fetch(:account))

      render(:json => serialize_model(operation.fetch(:account), [], []), :status => :created)
    end

    def destroy
      authenticate_account!

      sign_out(current_account)

      render(:json => serialize_model(current_account, [], []), :status => :ok)
    end
  end
end

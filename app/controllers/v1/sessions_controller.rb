module V1
  class SessionsController < ::V1::ApplicationController
    def create
      payload = Sessions::CreateSchema.new(request.parameters)
      operation = LoginAccountOperation.(
        :scope => policy_scope(Session, :policy_scope_class => SessionPolicy),
        :shared => payload.data.attributes.email,
        :secret => payload.data.attributes.password
      )

      authorize(operation.fetch(:account))

      sign_in("account", operation.fetch(:account))

      render(
        :json => ::V1::SessionMaterializer.new(:object => operation.fetch(:account)),
        :status => :created
      )
    end

    def destroy
      authenticate_account!

      sign_out(current_account)

      render(
        :json => ::V1::SessionMaterializer.new(:object => current_account),
        :status => :ok
      )
    end
  end
end

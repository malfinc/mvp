module V1
  class SessionsController < ::V1::ApplicationController
    discoverable(
      :version => "v1",
      :namespace => "sessions"
    )

    def create
      parameters = SessionsCreateSchema.new(request.parameters).as_json || {}

      operation = LoginAccountOperation.(parameters)

      authorize(operation.fetch(:account))

      sign_in("account", operation.fetch(:account))

      render(:json => serialize_model(operation.account), :status => :created)
    end

    def destroy
      authenticate_account!

      realization = JSONAPI::Realizer.create(
        SessionsDestroySchema.new(request.parameters).as_json || {},
        :scope => policy_scope(Session),
        :headers => request.headers
      )

      authorize(realization.model)

      AddToCartOperation.(:cart_item => realization.model)

      render(:json => serialize(realization), :status => :created)
    end
  end
end

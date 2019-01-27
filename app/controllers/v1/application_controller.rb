module V1
  class ApplicationController < ::ApplicationController
    include(Pundit)
    include(JSONAPI::Realizer::Controller)
    include(JSONAPI::Materializer::Controller)

    after_action(:verify_authorized)
    after_action(:verify_policy_scoped)

    private def inline_jsonapi(model: self.const_get("MODEL"), schema:, realizer: self.const_get("REALIZER"), materializer: self.const_get("MATERIALIZER"), intent: nil, scope: nil, policy_scope_class: nil, parameters: nil, context: {:policy => ->(object) {self.const_get("POLICY").new(current_account, object)}})
      @intent = intent || @_action_name
      @schema = schema
      @payload = @schema.new(parameters || request.parameters)
      @record_scope = scope || model
      @policy_scope = if policy_scope_class
        policy_scope(@record_scope, :policy_scope_class => policy_scope_class)
      else
        policy_scope(@record_scope)
      end
      @headers = request.headers
      @realizer = realizer
      @materializer = materializer
      @realization = @realizer.new(
        :intent => @intent,
        :parameters => @payload,
        :headers => @headers,
        :scope => @policy_scope,
        :context => context || {}
      )

      if params.key?(:id)
        authorize(@realization.object)

        return unless stale?(:etag => @realization.object)

        if block_given? then yield(@realization.object) end

        @materializer.new(
          **@realization,
          :context => context || {}
        )
      else
        if block_given? then yield end

        authorize(@policy_scope)

        @materializer.new(
          **@realization,
          :context => context || {}
        )
      end
    end

    private def pundit_user
      current_account
    end

    private def upsert_parameter(tree, parameters)
      tree.reduce(parameters) do |accumulated_parameters, (keychain, mapping)|
        mapping.reduce(accumulated_parameters) do |accumulated_mapping, (before, after)|
          if accumulated_mapping.dig(*keychain) == before
            accumulated_mapping.deep_merge(
              keychain.reverse.reduce(after) do |accumulated, key|
                {key => accumulated}
              end
            )
          else
            accumulated_mapping
          end
        end
      end
    end
  end
end

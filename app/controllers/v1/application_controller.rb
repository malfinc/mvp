module V1
  class ApplicationController < ::ApplicationController
    include(JSONAPI::Home)
    include(Pundit)

    before_action(:assign_paper_trail_context)
    before_bugsnag_notify(:assign_user_context, :if => :account_signed_in?)
    before_bugsnag_notify(:assign_metadata_tab)
    after_action(:verify_authorized)
    after_action(:verify_policy_scoped)

    private def pundit_user
      current_account
    end

    private def assign_paper_trail_context
      if account_signed_in?
        PaperTrail.request.whodunnit = current_account.email
      else
        PaperTrail.request.whodunnit = "anonymous@system.local"
      end

      PaperTrail.request.controller_info = {
        :actor_id => if account_signed_in? then current_account.id end,
        :context_id => request.request_id
      }
    end

    private def assign_user_context(report)
      if account_signed_in?
        report.user = {
          :email => current_account.email,
          :id => current_account.id
        }
      end
    end

    private def assign_metadata_tab(report)
      report.add_tab(
        :metadata,
        :request_id => request.request_id,
        :session_id => if account_signed_in? then session.id end
      )
    end

    private def serialize(realization)
      if realization.respond_to?(:models)
        serialize_models(realization)
      else
        serialize_model(realization)
      end
    end

    private def serialize_model(realization)
      JSONAPI::Serializer.serialize(
        realization.model,
        **serialize_options,
        :fields => if realization.fields.any? then realization.fields end,
        :include => if realization.includes.any? then realization.includes end,
        :is_collection => false,
        :context => default_context({
          policy: policy(realization.model)
        })
      )
    end

    private def serialize_models(realization)
      JSONAPI::Serializer.serialize(
        realization.models,
        **serialize_options,
        :fields => if realization.fields.any? then realization.fields end,
        :include => if realization.includes.any? then realization.includes end,
        :is_collection => true,
        :context => default_context({
          policy: realization.models.map(&method(:policy))
        })
      )
    end

    private def serialize_options
      {
        :meta => serialized_metadata,
        :links => serialized_links,
        :jsonapi => serialized_jsonapi,
        :namespace => ::V1
      }
    end

    private def current_cart
      if account_signed_in?
        @current_cart ||= current_account.unfinished_cart
      end
    end

    private def serialized_metadata
      {
        :api => {
          :version => "1"
        }
      }
    end

    private def serialized_links
      {
        :discovery => {
          :href => "/"
        }
      }
    end

    private def serialized_jsonapi
      {
        :version => "1.0"
      }
    end

    private def default_context(default)
      {
        **default,
        **if respond_to?(:context) then context else {} end
      }
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

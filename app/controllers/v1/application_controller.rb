module V1
  class ApplicationController < ::ApplicationController
    include(JSONAPI::Home)
    include(Pundit)

    before_action(:reject_missing_content_type_header)
    before_action(:reject_missing_accept_header)
    before_action(:reject_incorrect_content_type_header)
    before_action(:reject_incorrect_accept_header)
    after_action(:verify_authorized)
    after_action(:verify_policy_scoped)

    private def reject_missing_content_type_header
      return if request.body.size.zero?
      raise(MissingContentTypeHeaderError) unless request.headers.key?("Content-Type")
    end

    private def reject_missing_accept_header
      raise(MissingAcceptHeaderError) unless request.headers.key?("Accept")
    end

    private def reject_incorrect_content_type_header
      return if request.body.size.zero?
      raise(IncorrectContentTypeHeaderError) unless request.headers.fetch("Content-Type").include?(JSONAPI::MEDIA_TYPE)
    end

    private def reject_incorrect_accept_header
      raise(IncorrectAcceptHeaderError) unless request.headers.fetch("Accept").include?(JSONAPI::MEDIA_TYPE)
    end

    private def pundit_user
      current_account
    end

    private def serialize(realization)
      if realization.respond_to?(:models)
        serialize_models(realization.models, realization.fields, realization.includes)
      else
        serialize_model(realization.model, realization.fields, realization.includes)
      end
    end

    private def serialize_model(model, fields, includes)
      JSONAPI::Serializer.serialize(
        model,
        **serialize_options,
        :fields => if fields.any? then fields end,
        :include => if includes.any? then includes end,
        :is_collection => false,
        :context => default_context(
          :policy => policy(model)
        )
      )
    end

    private def serialize_models(models, fields, includes)
      JSONAPI::Serializer.serialize(
        models,
        **serialize_options,
        :fields => if fields.any? then fields end,
        :include => if includes.any? then includes end,
        :is_collection => true,
        :context => default_context(
          :policy => models.map(&method(:policy))
        )
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

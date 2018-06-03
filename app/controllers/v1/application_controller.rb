module V1
  class ApplicationController < ::ApplicationController
    include JSONAPI::Home
    include Pundit

    RECURSIVE_TREE = ->(accumulated, key) {accumulated[key] = Hash.new(&RECURSIVE_TREE)}

    rescue_from StandardError, with: :generic_error_handling
    rescue_from JSONAPI::Realizer::Error::MissingAcceptHeader, with: :missing_accept_header
    rescue_from JSONAPI::Realizer::Error::InvalidAcceptHeader, with: :invalid_accept_header
    rescue_from JSONAPI::Realizer::Error::MalformedDataRootProperty, with: :malformed_data_root_property
    rescue_from Pundit::NotAuthorizedError, with: :access_not_authorized
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from StateMachines::InvalidTransition, with: :invalid_transition
    rescue_from ApplicationError, with: :application_exception

    private def generic_error_handling(exception)
      Rails.logger.info("exception=#{exception.class.name.inspect} message=#{exception.message.inspect}")
      Rails.logger.debug(exception.full_message)
      raise exception
    end

    # TODO: Wrap these in an error wrapper so they have the same properties as others and reraise
    private def missing_accept_header
      head :not_acceptable
    end

    # TODO: Wrap these in an error wrapper so they have the same properties as others and reraise
    private def invalid_accept_header
      head :not_acceptable
    end

    # TODO: Wrap these in an error wrapper so they have the same properties as others and reraise
    private def access_not_authorized(exception)
      Rails.logger.debug("Pundit #{exception.policy.class.name} did not authorize #{exception.query}")

      head :unauthorized
    end

    # TODO: Wrap these in an error wrapper so they have the same properties as others and reraise
    private def malformed_data_root_property
      head :unprocessable_entity
    end

    # TODO: Wrap these in an error wrapper so they have the same properties as others and reraise
    private def invalid_transition(exception)
      Rails.logger.debug("#{exception.object.class.name} failed to save: #{exception.object.errors.full_messages.to_sentence}")
      render json: JSONAPI::Serializer.serialize_errors(exception.object.errors), status: :unprocessable_entity
    end

    # TODO: Wrap these in an error wrapper so they have the same properties as others and reraise
    private def record_invalid(exception)
      Rails.logger.debug("#{exception.record.class.name} failed to save: #{exception.record.errors.full_messages.to_sentence}")
      render json: JSONAPI::Serializer.serialize_errors(exception.record.errors), status: :unprocessable_entity
    end

    private def application_exception(exception)
      binding.pry
      render json: JSONAPI::Serializer.serialize_errors(exception.as_jsonapi_errors), status: :unprocessable_entity
    end

    private def serialize(realization)
      JSONAPI::Serializer.serialize(
        if realization.respond_to?(:models) then realization.models else realization.model end,
        is_collection: realization.respond_to?(:models),
        meta: serialized_metadata,
        links: serialized_links,
        jsonapi: serialized_jsonapi,
        fields: if realization.fields.any? then realization.fields end,
        include: if realization.includes.any? then realization.includes end,
        namespace: ::V1
      )
    end

    private def ensure_account_exists
      unless account_signed_in?
        sign_in(Account.create!)
      end
    end

    private def ensure_cart_exists
      cart_loaded_up?
    end

    private def cart_is_unfinished?
      current_cart.present? && current_cart.unfinished?
    end

    private def cart_loaded_up?
      current_cart.present?
    end

    private def current_cart
      @current_cart ||= current_account.unfinished_cart if account_signed_in?
    end

    private def serialized_metadata
      {
        api: {
          version: "1"
        }
      }
    end

    private def serialized_links
      {
        discovery: {
          href: "/"
        }
      }
    end

    private def serialized_jsonapi
      {
        version: "1.0"
      }
    end

    # upsert_parameter(
    #   {
    #     ["id"] => {"me" => current_cart.id},
    #     ["data", "id"] => {"me" => current_cart.id}
    #   }
    #   request.parameters
    # )
    # keychains.reduce(parameters) do |accumulated, keychain|
    #   if accumulated.dig(*keychain) == before
    #     accumulated.deep_merge(
    #       keychain.reverse.reduce(after) do |accumulated, key|
    #         { key => accumulated }
    #       end
    #     )
    #   else
    #     accumulated
    #   end
    # end
    private def upsert_parameter(tree, parameters)
      tree.reduce(parameters) do |accumulated_parameters, (keychain, mapping)|
        mapping.reduce(accumulated_parameters) do |accumulated_mapping, (before, after)|
          if accumulated_mapping.dig(*keychain) == before
            accumulated_mapping.deep_merge(
              keychain.reverse.reduce(after) do |accumulated, key|
                { key => accumulated }
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

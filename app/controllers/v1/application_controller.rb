module V1
  class ApplicationController < ::ApplicationController
    include JSONAPI::Home

    rescue_from JSONAPI::Realizer::Error::MissingAcceptHeader, with: :missing_accept_header
    rescue_from JSONAPI::Realizer::Error::InvalidAcceptHeader, with: :invalid_accept_header
    rescue_from JSONAPI::Realizer::Error::MalformedDataRootProperty, with: :malformed_data_root_property
    rescue_from Pundit::NotAuthorizedError, with: :access_not_authorized
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from CartItemWithoutProductError, with: :malformed_request

    private def missing_accept_header
      head :not_acceptable
    end

    private def invalid_accept_header
      head :not_acceptable
    end

    private def access_not_authorized(exception)
      Rails.logger.debug("Pundit #{exception.policy.class.name} did not authorize #{exception.query}")

      head :unauthorized
    end

    private def malformed_data_root_property
      head :unprocessable_entity
    end

    private def record_invalid(exception)
      render json: JSONAPI::Serializer.serialize_errors(exception.record.errors), status: :unprocessable_entity
    end

    private def malformed_request(exception)
      render json: JSONAPI::Serializer.serialize_errors(exception.as_errors), status: :unprocessable_entity
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

    private def cart_is_fresh?
      current_cart.present? && current_cart.fresh?
    end

    private def cart_loaded_up?
      current_cart.present?
    end

    private def current_cart
      @current_cart ||= current_account.fresh_cart if account_signed_in?
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

    private def replacing_myself(keychain, parameters)
      case
      when parameters.dig(*keychain) == "me" && account_signed_in?
        current_account.id
      when parameters.dig(*keychain) == "me"
        raise MissingAuthenticationError
      else
        parameters.dig(*keychain)
      end
    end
  end
end

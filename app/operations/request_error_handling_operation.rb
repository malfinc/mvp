class RequestErrorHandlingOperation < ApplicationOperation
  task(:write_to_log)
  task(:notify_bugsnag)
  task(:render_output)

  schema(:write_to_log) do
    field(:exception, :type => Types.Instance(StandardError))
  end
  def write_to_log(state:)
    case state.exception
    when StateMachines::InvalidTransition
      Rails.logger.debug("#{state.exception.object.class.name} failed to save due to #{state.exception.object.errors.full_messages.to_sentence}")
    when Pundit::NotAuthorizedError
      Rails.logger.debug("#{state.exception.policy.class.name} did not allow #{state.exception.policy.actor.to_gid} to #{state.exception.query.delete("?")} a #{state.exception.policy.record.class}")
    when ActiveRecord::RecordInvalid
      Rails.logger.error("#{state.exception.record.class.name} failed to save due to #{state.exception.record.errors.full_messages.to_sentence}")
      Rails.logger.error(state.exception.record.attributes.as_json)
    else
      Rails.logger.error("#{state.exception.class.name} was raised due to #{state.exception.message.inspect}")
    end
    Rails.logger.debug(state.exception.full_message)
  end

  schema(:notify_bugsnag) do
    field(:controller, :type => Types.Instance(ApplicationController))
    field(:exception, :type => Types.Instance(StandardError))
  end
  def notify_bugsnag(state:)
    return unless Rails.env.production?
    if state.controller.account_signed_in?
      Bugsnag.before_notify_callbacks << ->(report) do
        report.user = {
          id: state.controller.current_account.id
        }
      end
    end

    Bugsnag.before_notify_callbacks << ->(report) do
      report.add_tab(
        :request,
        :request_id => state.controller.request.request_id,
        :session_id => if state.controller.account_signed_in? then state.controller.session.id end,
        :operation_id => operation_id,
        :step_id => step_id
      )
    end

    Bugsnag.notify(state.exception)
  end

  schema(:render_output) do
    field(:controller, :type => Types.Instance(ApplicationController))
    field(:exception, :type => Types.Instance(StandardError))
  end
  def render_output(state:)
    case state.exception
    when JSONAPI::Realizer::Error::MissingAcceptHeader then missing_accept_header(state.controller)
    when JSONAPI::Realizer::Error::InvalidAcceptHeader then invalid_accept_header(state.controller)
    when JSONAPI::Realizer::Error::MalformedDataRootProperty then malformed_data_root_property(state.controller)
    when Pundit::NotAuthorizedError then access_not_authorized(state.controller)
    when ActiveRecord::RecordInvalid then record_invalid(state.controller, state.exception)
    when ActiveRecord::RecordNotFound then record_not_found(state.controller)
    when StateMachines::InvalidTransition then invalid_transition(state.controller)
    when SmartParams::Error::InvalidPropertyType then invalid_property_type(state.controller, state.exception)
    when ApplicationError then application_exception(state.controller, state.exception)
    else unhandled_exception(state.controller)
    end
  end

  private def record_invalid(controller, exception)
    controller.render(
      :json => JSONAPI::Serializer.serialize_errors(exception.record.errors),
      :status => :unprocessable_entity
    )
  end

  private def record_not_found(controller)
    controller.head(:not_found)
  end

  private def application_exception(controller, exception)
    controller.render(
      :json => JSONAPI::Serializer.serialize_errors(standard_jsonapi_error(exception)),
      :status => :unprocessable_entity
    )
  end

  private def malformed_data_root_property(controller)
    controller.head(:unprocessable_entity)
  end

  private def access_not_authorized(controller)
    controller.head(:unauthorized)
  end

  private def invalid_accept_header(controller)
    controller.head(:not_acceptable)
  end

  private def missing_accept_header(controller)
    controller.head(:not_acceptable)
  end

  private def invalid_property_type(controller, exception)
    controller.render(
      :json => JSONAPI::Serializer.serialize_errors([
        {
          "title" => "Resource Schema Mismatch",
          "code" => "resource_schema_mismatch",
          "detail" => "The expected value at the pointer does not match the schema",
          "source" => {
            "expected-type" => exception.wanted.name,
            "pointer" => "/#{exception.keychain.join("/")}"
          }
        }
      ]),
      :status => :unprocessable_entity
    )
  end

  private def unhandled_exception(controller)
    controller.head(:internal_server_error)
  end

  private def standard_jsonapi_error(exception)
    [
      {
        "title" => exception.title,
        "code" => exception.class.name.underscore,
        "detail" => exception.detail
      }
    ]
  end
end

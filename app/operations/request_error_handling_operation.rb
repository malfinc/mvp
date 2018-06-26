class RequestErrorHandlingOperation < ApplicationOperation
  task :write_to_log
  task :render_output
  task :missing_accept_header, required: false
  task :invalid_accept_header, required: false
  task :malformed_data_root_property, required: false
  task :access_not_authorized, required: false
  task :record_invalid, required: false
  task :application_exception, required: false
  task :unhandled_exception, required: false

  schema :write_to_log do
    field :exception, type: Types.Instance(StandardError)
  end
  def write_to_log(state:)
    case state.exception
    when ActiveRecord::RecordInvalid
      Rails.logger.debug("#{state.exception.object.class.name} failed to save due to #{state.exception.object.errors.full_messages.to_sentence}")
    when Pundit::NotAuthorizedError
      Rails.logger.debug("#{state.exception.policy.class.name} does not authorize #{state.exception.query}")
    when ActiveRecord::RecordInvalid, StateMachines::InvalidTransition
      Rails.logger.error("#{state.exception.record.class.name} failed to save due to #{state.exception.record.errors.full_messages.to_sentence}")
    else
      Rails.logger.error("#{state.exception.class.name} failed to save due to #{state.exception.message.inspect}")
    end
    Rails.logger.debug(state.exception.full_message)
  end

  schema :render_output do
    field :exception, type: Types.Instance(StandardError)
  end
  def render_output(state:)
    case state.exception
    when JSONAPI::Realizer::Error::MissingAcceptHeader then drift(to: :missing_accept_header)
    when JSONAPI::Realizer::Error::InvalidAcceptHeader then drift(to: :invalid_accept_header)
    when JSONAPI::Realizer::Error::MalformedDataRootProperty then drift(to: :malformed_data_root_property)
    when Pundit::NotAuthorizedError then drift(to: :access_not_authorized)
    when ActiveRecord::RecordInvalid then drift(to: :record_invalid)
    when StateMachines::InvalidTransition then drift(to: :invalid_transition)
    when ApplicationError then drift(to: :application_exception)
    else drift(to: :unhandled_exception)
    end
  end

  schema :record_invalid do
    field :controller, type: Types.Instance(ApplicationController)
  end
  def record_invalid(state:)
    state.controller.render json: JSONAPI::Serializer.serialize_errors(state.exception.record.errors), status: :unprocessable_entity
  end

  schema :application_exception do
    field :controller, type: Types.Instance(ApplicationController)
  end
  def application_exception(state:)
    state.controller.render json: JSONAPI::Serializer.serialize_errors(state.exception.as_jsonapi_errors), status: :unprocessable_entity
  end

  schema :malformed_data_root_property do
    field :controller, type: Types.Instance(ApplicationController)
  end
  def malformed_data_root_property(state:)
    state.controller.head :unprocessable_entity
  end

  schema :malformed_data_root_property do
    field :controller, type: Types.Instance(ApplicationController)
  end
  def malformed_data_root_property(state:)
    state.controller.head :unprocessable_entity
  end

  schema :access_not_authorized do
    field :controller, type: Types.Instance(ApplicationController)
  end
  def access_not_authorized(state:)
    state.controller.head :unauthorized
  end

  schema :invalid_accept_header do
    field :controller, type: Types.Instance(ApplicationController)
  end
  def invalid_accept_header(state:)
    state.controller.head :not_acceptable
  end

  schema :missing_accept_header do
    field :controller, type: Types.Instance(ApplicationController)
  end
  def missing_accept_header(state:)
    state.controller.head :not_acceptable
  end

  schema :unhandled_exception do
    field :controller, type: Types.Instance(ApplicationController)
  end
  def unhandled_exception(state:)
    state.controller.head :internal_server_error
  end
end

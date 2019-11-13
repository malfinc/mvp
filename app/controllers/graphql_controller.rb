class GraphqlController < ApplicationController
  def execute
    render(:json => PoutineerGraphql.execute(
      params[:query],
      :variables => ensure_hash(params[:variables]),
      :operation_name => params[:operationName],
      :context => {
        # Query context goes here, for example:
        # current_user: current_user,
      },
    ))
  rescue StandardError => handled_exception
    raise(handled_exception) unless Rails.env.development?

    Rails.logger.error(handled_exception.message)
    Rails.logger.error(handled_exception.backtrace.join("\n"))

    render(:json => {:error => {:message => handled_exception.message, :backtrace => handled_exception.backtrace}, :data => {}}, :status => :internal_server_error)
  end

  # Handle form data, JSON body, or a blank value
  private def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise(ArgumentError, "Unexpected parameter: #{ambiguous_param}")
    end
  end
end

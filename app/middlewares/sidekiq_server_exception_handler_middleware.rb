class SidekiqServerExceptionHandlerMiddleware
  def call(_, _, _)
    yield
  rescue StandardError => exception
    Rails.logger.error(exception.message)

    raise(exception)
  end
end

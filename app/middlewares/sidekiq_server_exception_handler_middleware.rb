class SidekiqServerExceptionHandlerMiddleware
  def call(_, _, _)
    begin
      yield
    rescue StandardError => exception
      Rails.logger.error(exception.message)

      raise exception
    end
  end
end

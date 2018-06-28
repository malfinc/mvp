class SidekiqServerExceptionHandlerMiddleware
  def call(_, _, _)
    begin
      yield
    rescue StandardError => exception
      puts exception.message
    end
  end
end

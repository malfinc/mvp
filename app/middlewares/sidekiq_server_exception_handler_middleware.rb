class SidekiqServerExceptionHandlerMiddleware
  def call()
    begin
      yield
    rescue StandardError => exception
      puts exception.message
    end
  end
end

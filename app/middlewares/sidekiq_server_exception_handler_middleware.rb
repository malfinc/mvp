class SidekiqServerExceptionHandlerMiddleware
  def call(worker, job, queue)
    begin
      yield
    rescue StandardError => exception
      puts exception.message
    end
  end
end

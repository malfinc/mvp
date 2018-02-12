class ApplicationError < StandardError
  def status
    500
  end
end

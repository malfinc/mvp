class MalformedAuthenticationError < ApplicationError
  def status
    422
  end

  def detail
    "request's Authentication HTTP header is malformed"
  end
end

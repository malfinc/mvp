class MalformedAuthenticationError < ApplicationError
  def status
    422
  end

  def detail
    "request Authentication Header is malformed"
  end
end

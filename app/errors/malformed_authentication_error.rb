class MalformedAuthenticationError < ApplicationError
  def status
    422
  end
end

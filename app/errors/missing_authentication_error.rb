class MissingAuthenticationError < ApplicationError
  def status
    401
  end
end

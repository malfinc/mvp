class InvalidLoginError < ApplicationError
  def status
    422
  end

  def detail
    "the email or password you provided was incorrect"
  end
end

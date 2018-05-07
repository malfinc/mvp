class NotEnoughMoneyProvidedError < ApplicationError
  def status
    422
  end

  def detail
    "the payments provided do not add up to equal or more than the total"
  end
end

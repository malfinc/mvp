class NotEnoughMoneyProvidedError < ApplicationError
  def status
    422
  end

  def as_errors
    [
      {
        "title" => "Not Enough Money Provided",
        "detail" => "The payments provided do not add up to equal or more than the total."
      }
    ]
  end
end

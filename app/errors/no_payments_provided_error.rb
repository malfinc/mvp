class NoPaymentsProvidedError < ApplicationError
  def status
    422
  end

  def detail
    "all purchases must be made with some form of payment method"
  end
end

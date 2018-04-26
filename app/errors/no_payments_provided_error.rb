class NoPaymentsProvidedError < ApplicationError
  def status
    422
  end

  def as_errors
    [
      {
        "title" => "No Payments Provided",
        "detail" => "All purchases must be made with proper payments."
      }
    ]
  end
end

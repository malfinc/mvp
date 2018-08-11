class MissingContentTypeHeaderError < ApplicationError
  def status
    422
  end

  def detail
    "missing header Content-Type"
  end
end

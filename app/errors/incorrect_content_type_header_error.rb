class IncorrectContentTypeHeaderError < ApplicationError
  def status
    422
  end

  def detail
    "Content-Type header contained an incorrect media-type"
  end
end

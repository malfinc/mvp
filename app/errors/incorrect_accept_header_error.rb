class IncorrectAcceptHeaderError < ApplicationError
  def status
    422
  end

  def detail
    "Accept header contained an incorrect media-type"
  end
end

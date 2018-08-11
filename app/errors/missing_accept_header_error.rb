class MissingAcceptHeaderError < ApplicationError
  def status
    422
  end

  def detail
    "missing Accept header"
  end
end

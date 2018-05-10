class ApplicationError < StandardError
  def status
    500
  end

  def title
    self.class.name.gsub("Error", "").underscore.humanize.titleize
  end

  def as_jsonapi_error
    {
      "title" => title,
      "detail" => detail
    }
  end

  def as_jsonapi_errors
    [
      as_jsonapi_error
    ]
  end
end

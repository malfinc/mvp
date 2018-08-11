class ApplicationError < StandardError
  def status
    500
  end

  def title
    self.class.name.underscore.humanize.titleize
  end
end

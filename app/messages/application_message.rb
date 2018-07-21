class ApplicationMessage
  include(ActiveModel::Model)

  attr_accessor(:to)
  attr_accessor(:message)

  def self.call(**keyword_arguments)
    new(**keyword_arguments).()
  end

  private def via_realtime; end

  private def deliver_later; end

  private def deliver_now; end
end

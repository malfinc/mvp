module PunditNotAuthorizedErrorMessage
  def initialize(options = {})
    if options.is_a? String
      message = options
    else
      @query  = options[:query]
      @record = options[:record]
      @policy = options[:policy]

      message = options.fetch(:message) { "#{@policy.class.name}##{query} returned false for a #{record.class.name}" }
    end

    super(message)
  end
end

Pundit::NotAuthorizedError.prepend(PunditNotAuthorizedErrorMessage)

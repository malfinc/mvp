module RailsConsoleAccountAccess
  def initialize(*arguments)
    if Account.exists? && Rails.env.production?
      Rails.logger.info("Welcome! What is your email?")
      email = gets.chomp

      raise(NoConsoleAuthenticationProvidedException) if email.blank?

      actor = Account.find_by!(:email => email)

      Rails.logger.info("What is your password?")
    elsif Account.exists?
      actor = Account.with_role_state(:administrator).last
    else
      actor = ActorNull.new
    end

    PaperTrail.request.whodunnit = actor.email
    PaperTrail.request.controller_info = {
      :context_id => SecureRandom.uuid(),
      :actor_id => actor.id
    }

    super(*arguments)
  rescue PG::ConnectionBad => exception
    puts exception
    super(*arguments)
  end
end

Rails::Console.prepend(RailsConsoleAccountAccess) if Rails.const_defined?("Console")

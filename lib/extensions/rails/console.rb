module Rails
  class Console
    initialize = instance_method(:initialize)

    define_method :initialize do |*args|
      unless Rails.env.development? || Rails.env.test?
        Rails.logger.info("Welcome! What is your email?")
        email = gets.chomp

        raise(NoConsoleAuthenticationProvidedError) if email.blank?

        actor = Account.find_by!(:email => email)

        PaperTrail.request.whodunnit = actor
        PaperTrail.request.controller_info = {
          :actor_id => actor,
          :group_id => SecureRandom.uuid
        }
      end

      initialize.bind(self).(*args)
    end
  end
end

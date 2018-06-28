module Rails
  class Console
    initialize = instance_method(:initialize)

    define_method :initialize do |*args|
      unless Rails.env.development? || Rails.env.test?
        Rails.logger.info("Welcome! What is your email?")
        email = gets.chomp

        raise(NoConsoleAuthenticationProvidedError) if email.blank?

        actor = Account.find_by!(:email => email)
      else
        actor = Account.with_role_state(:administrator).last
      end

      PaperTrail.request(:whodunnit => actor.to_gid, :controller_info => {:group_id => SecureRandom.uuid(), :actor_id => actor.id}) do
        initialize.bind(self).(*args)
      end
    end
  end
end

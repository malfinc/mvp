module Rails
  class Console
    initialize = instance_method(:initialize)

    define_method :initialize do |*args|
      unless Rails.env.development? || Rails.env.test?
        puts "Welcome! What is your email?"
        email = gets.chomp

        raise NoConsoleAuthenticationProvidedError unless email.present?

        PaperTrail.request.whodunnit = Account.find_by!(email: email)
      end

      initialize.bind(self).call(*args)
    end
  end
end

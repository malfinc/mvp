module Poutineer
  class TokenStrategy < Devise::Strategies::Base
    def valid?
      present? && !exception?
    end

    def authenticate!
      raise(authentication_secret) if exception?
      raise(MissingAuthenticationError) unless found?
      raise(fail!(:incorrect_credentials)) unless matches?

      success!(record)
    end

    delegate(:present?, :to => :authentication_secret)

    private def authentication_secret
      request.env.fetch(Rack::AuthenticationBearer::RACK_KEY, nil)
    end

    private def record
      @record ||= Account.find_by(:authentication_secret => authentication_secret)
    end

    private def found?
      record.present?
    end

    private def matches?
      Devise.secure_compare(record.authentication_secret, authentication_secret)
    end

    private def exception?
      authentication_secret.is_a?(Class) && authentication_secret < StandardError
    end
  end
end

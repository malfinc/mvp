module BlankApiRails
  class TokenStrategy < Devise::Strategies::Base
    def valid?
      present? && !exception?
    end

    def authenticate!
      raise authentication_secret if exception?
      raise MissingAuthenticationError unless found?
      raise fail!(:incorrect_credentials) unless matches?

      success! record
    end

    private def authentication_secret
      request.env.fetch(Rack::AuthenticationBearer::RACK_KEY, nil)
    end

    private def present?
      authentication_secret.present?
    end

    private def record
      @record ||= Account.find_by(authentication_secret: authentication_secret)
    end

    private def found?
      record.present?
    end

    private def matches?
      Devise.secure_compare(record.authentication_secret, authentication_secret)
    end

    private def exception?
      authentication_secret.kind_of?(Class) && authentication_secret < StandardError
    end
  end
end

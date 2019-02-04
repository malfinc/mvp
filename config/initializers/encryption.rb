if File.exists?(Rails.root.join("config", "credentials.yml.enc"))
  ENCRYPTION_KEY_GENERATOR = ActiveSupport::KeyGenerator.new(Rails.application.credentials.key)
  ENCRYPTION_KEY = ENCRYPTION_KEY_GENERATOR.generate_key(Rails.application.credentials.fetch(:encryption).fetch(:salt), 32)
  ENCRYPTOR = ActiveSupport::MessageEncryptor.new(ENCRYPTION_KEY)
end

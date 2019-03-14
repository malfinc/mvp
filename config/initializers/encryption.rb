if File.exists?(Rails.root.join("config", "credentials.yml.enc"))
  ENCRYPTION_KEY_GENERATOR = ActiveSupport::KeyGenerator.new(Poutineer.configuration.fetch_deep(:encryption, :key))
  ENCRYPTION_KEY = ENCRYPTION_KEY_GENERATOR.generate_key(Poutineer.configuration.fetch_deep(:encryption, :salt), 32)
  ENCRYPTOR = ActiveSupport::MessageEncryptor.new(ENCRYPTION_KEY)
end

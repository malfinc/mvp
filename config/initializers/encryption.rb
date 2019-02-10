if File.exists?(Rails.root.join("config", "credentials.yml.enc"))
  ENCRYPTION_KEY_GENERATOR = ActiveSupport::KeyGenerator.new(BlankApiRails.configuration.fetch_deep(:encryption, :key))
  ENCRYPTION_KEY = ENCRYPTION_KEY_GENERATOR.generate_key(BlankApiRails.configuration.fetch_deep(:encryption, :salt), 32)
  ENCRYPTOR = ActiveSupport::MessageEncryptor.new(ENCRYPTION_KEY)
end

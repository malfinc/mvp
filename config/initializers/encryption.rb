if Poutineer.secrets.present?
  ENCRYPTION_KEY_GENERATOR = ActiveSupport::KeyGenerator.new(Poutineer.secrets.fetch_deep(:encryption, :key))
  ENCRYPTION_KEY = ENCRYPTION_KEY_GENERATOR.generate_key(Poutineer.secrets.fetch_deep(:encryption, :salt), 32)
  ENCRYPTOR = ActiveSupport::MessageEncryptor.new(ENCRYPTION_KEY)
end

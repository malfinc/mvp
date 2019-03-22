require_relative("source/extensions")
require_relative("source/token_strategy")
require_relative("source/redis")

module Poutineer
  def self.settings
    YAML.safe_load(File.read(Rails.root.join("config", "settings.yml"))).fetch(Rails.env).with_indifferent_access
  end

  def self.secrets
    return false if Rails.application.credentials.blank?

    Rails.application.credentials.public_send(Rails.env).with_indifferent_access
  end
end

class VersionJob < ApplicationJob
  sidekiq_options(:queue => "versions")

  def perform(version_class, attributes)
    version_class.constantize.create!(attributes)
  end
end

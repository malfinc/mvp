class VersionJob < ApplicationJob
  sidekiq_options(:queue => "versions", :unique_across_queues => true, :lock => :until_executed, :log_duplicate_payload => true)

  include(PaperTrail::Background::Sidekiq)
end

# This file is copied to spec/ when you run "rails generate rspec:install"
require("spec_helper")
ENV["RAILS_ENV"] ||= "test"
require(File.expand_path("../config/environment", __dir__))
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require("rspec/rails")
# require("paper_trail/frameworks/rspec")
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

require_relative("support/matchers/jsonapi_response")
require_relative("support/contexts/jsonapi_request")
require_relative("support/contexts/jsonapi_requests")
require_relative("support/contexts/google_places_api")

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec::Sidekiq.configure do |config|
  # Clears all job queues before each example
  config.clear_all_enqueued_jobs = true

  # Whether to use terminal colours when outputting messages
  config.enable_terminal_colours = false

  # Warn when jobs are not enqueued to Redis but to a job array
  config.warn_when_jobs_not_processed_by_sidekiq = true
end

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = Rails.root.join("spec", "fixtures")

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  config.include(FactoryBot::Syntax::Methods)

  config.before(:suite) do
    PaperTrail.enabled = true
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :deletion
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.around do |example|
    PaperTrail.request(:whodunnit => Account::MACHINE_ID, :controller_info => {:actor_id => nil, :context_id => SecureRandom.uuid()}) do
      example.run
    end
  end

  config.around(:each) do |example|
    Sidekiq::Testing.inline! do
      example.run
    end
  end

  config.before(:suite) do
    PaperTrail.enabled = true
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :deletion
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.around do |example|
    PaperTrail.request(:whodunnit => Account::MACHINE_ID, :controller_info => {:actor_id => nil, :context_id => SecureRandom.uuid()}) do
      example.run
    end
  end

  config.around(:each) do |example|
    Sidekiq::Testing.inline! do
      example.run
    end
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.before(:each) do
    Blank::REDIS_OBJECTS_CONNECTION_POOL.with(&:flushdb)
    Blank::REDIS_SIDEKIQ_CLIENT_CONNECTION_POOL.with(&:flushdb)
    Blank::REDIS_SIDEKIQ_SERVER_CONNECTION_POOL.with(&:flushdb)
    Blank::REDIS_CACHE_CONNECTION_POOL.with(&:flushdb)
  end
end

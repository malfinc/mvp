source "https://rubygems.org"

ruby "2.5.0"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "5.1.5"
gem "oj", "3.5.1"
gem "pg", "0.21.0"
gem "puma", "3.11.4"
gem "hiredis", "0.6.1"
gem "redis", "4.0.1"
gem "redis-rails", "5.0.2"
gem "connection_pool", "2.2.1"
gem "rack-cors", "1.0.2"
gem "rack-attack", "5.2.0"
gem "redis-rack-cache", "2.0.2"
gem "rack-authentication_bearer", "2.0.2"
gem "secure_headers", "5.0.5"
gem "draper", "3.0.1"
gem "sidekiq", "5.1.3"
gem "devise", "4.4.3"
gem "devise-async", "1.0.0"
gem "groupdate", "4.0.0"
gem "active_record-pool", "2.0.0"
gem "state_machines-activerecord", "0.5.1"
gem "activerecord-like", "2.1"
gem "ar_after_transaction", "0.4.2"
gem "friendly_id", "5.2.3"
gem "strong_migrations", "0.2.2"
gem "ar_transaction_changes", "1.1.3"
gem "goldiloader", "2.1.0"
gem "rein", "3.4.0"
gem "gutentag", "2.3.1"
gem "country_select", "3.1.1"
gem "kaminari", "1.1.1"
gem "money-rails", "1.11.0"
gem "activerecord-safer_migrations", "2.0.0"
gem "migration_data", "0.3.0"
gem "puma_worker_killer", "0.1.0"
gem "pundit", "1.1.0"
gem "redis-objects", "1.4.0"
gem "pry-rails", "0.3.6"
gem "pry-doc", "0.13.4"
gem "jsonapi-serializers", "1.0.0"
gem "jsonapi-realizer", "4.1.0"
gem "jsonapi-home", "1.0.0"
gem "smart_params", "2.0.7"
gem "bugsnag", "6.7.1"
gem "paper_trail", "9.0.0"
gem "action_operation", "2.1.2"
gem "redlock", "0.2.2"

group :production do
  gem "rack-timeout", "0.4.2"
  gem "newrelic_rpm", "5.0.0.342"
end

group :development, :test do
  gem "dotenv-rails", "2.3.0", require: "dotenv/rails-now"
  gem "rspec-rails", "3.7.2"
  gem "listen", "3.1.5"
end

group :test do
  gem "timecop", "0.9.1"
end

group :development do
  gem "stackprof", "0.2.11", require: false
  gem "memory_profiler", "0.9.10", require: false
  gem "rack-mini-profiler", "1.0.0", require: false
  gem "flamegraph", "0.9.5", require: false
  gem "ruby-prof", "0.17.0", require: false
  gem "bullet", "5.7.5", require: false
  gem "brakeman", "4.2.1", require: false
  gem "active_record_query_trace", "1.5.4", require: false
  gem "rails-callback_log", "0.2.2", require: false
  gem "bundler-audit", "0.6.0"
end

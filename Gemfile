source "https://rubygems.org"

ruby "2.5.0"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "5.1.4"
gem "oj", "3.4.0"
gem "pg", "0.21.0"
gem "puma", "3.11.2"
gem "hiredis", "0.6.1"
gem "redis", "4.0.1"
gem "redis-rails", "5.0.2"
gem "connection_pool", "2.2.1"
gem "rack-cors", "1.0.2"
gem "rack-attack", "5.0.1"
gem "rack-authentication_bearer", "1.0.0"
gem "redis-rack-cache", "2.0.2"
gem "secure_headers", "5.0.4"
gem "draper", "3.0.1"
gem "strong_migrations", "0.2.0"
gem "goldiloader", "2.0.1"
gem "devise", "4.4.1"
gem "groupdate", "3.2.0"
gem "active_record-pool", "2.0.0"
gem "state_machines-activerecord", "0.5.0"
gem "puma_worker_killer", "0.1.0"
gem "pundit", "1.1.0"
gem "redis-objects", "1.4.0"
gem "friendly_id", "5.2.3"
gem "country_select", "3.1.1"
gem "gutentag", "2.0.0"
gem "kaminari", "1.1.1"
gem "sidekiq", "5.0.5"
gem "devise-async", "1.0.0"
gem "state_machines-audit_trail", "2.0.1"
gem "jsonapi-resources", "0.9.0"
gem "jsonapi-resources-home", "1.0.0"
gem "pry-rails", "0.3.6"
gem "pry-doc", "0.12.0"
gem "dry-types", "0.12.2"
gem "dry-struct", "0.4.0"
gem "money-rails", "1.10.0"
gem “activerecord-like”, “2.1”

group :production do
  gem "rack-timeout", "0.4.2"
  gem "bugsnag", "6.6.3"
  gem "newrelic_rpm", "4.7.1.340"
end

group :development, :test do
  gem "dotenv-rails", "2.2.1", require: "dotenv/rails-now"
  gem "rspec-rails", "3.7.2"
  gem "listen", "3.1.5"
end

group :test do
  gem "timecop", "0.9.1"
end

group :development do
  gem "stackprof", "0.2.11", require: false
  gem "memory_profiler", "0.9.8", require: false
  gem "rack-mini-profiler", "0.10.7", require: false
  gem "flamegraph", "0.9.5", require: false
  gem "ruby-prof", "0.17.0", require: false
  gem "bullet", "5.7.2", require: false
  gem "brakeman", "4.1.1", require: false
  gem "active_record_query_trace", "1.5.4", require: false
  gem "rails-callback_log", "0.2.2", require: false
  gem "bundler-audit", "0.6.0"
end

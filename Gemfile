source "https://rubygems.org"

ruby "2.4.2"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "5.1.4"
gem "pg", "0.21.0"
gem "oj", "3.3.8"
gem "puma", "3.10.0"
gem "redis", "4.0.1"
gem "hiredis", "0.6.1"
gem "connection_pool", "2.2.1"
gem "rack-cors", "1.0.1"
gem "rack-authentication_bearer", "1.0.0"
gem "rack-timeout", "0.4.2"
gem "rack-attack", "5.0.1"
gem "secure_headers", "4.0.1"
gem "goldiloader", "2.0.1"
gem "strong_migrations", "0.1.9"
gem "active_record-pool", "2.0.0"
gem "pry-rails", "0.3.6"
gem "pry-doc", "0.11.1"
gem "pundit", "1.1.0"
gem "envied", "0.9.1"
gem "groupdate", "3.2.0"
gem "state_machines-activerecord", "0.5.0"
gem "puma_worker_killer", "0.1.0"
gem "jsonapi-resources", "0.9.0"

group :development, :test do
  gem "stackprof", "0.2.10", require: false
  gem "memory_profiler", "0.9.8", require: false
  gem "rack-mini-profiler", "0.10.5", require: false
  gem "flamegraph", "0.9.5", require: false
  gem "ruby-prof", "0.16.2", require: false
  gem "active_record_query_trace", "1.5.4"
  gem "rails-callback_log", "0.2.2"
  gem "rspec-rails", "3.6.1"
  gem "listen", "3.1.5"
  gem "dotenv-rails", "2.2.1", require: "dotenv/rails-now"
  gem "bullet", "5.6.1"
  gem "brakeman", "4.0.1"
  gem "bundler-audit", "0.6.0"
end

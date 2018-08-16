source("https://rubygems.org")

ruby("2.5.0")

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem("rails", "5.2.1")
gem("oj", "3.6.5")
gem("pg", "1.0.0")
gem("puma", "3.12.0")
gem("hiredis", "0.6.1")
gem("redis", "4.0.1")
gem("redis-rails", "5.0.2")
gem("connection_pool", "2.2.2")
gem("rack-cors", "1.0.2")
gem("rack-attack", "5.4.0")
gem("rack-authentication_bearer", "2.0.2")
gem("secure_headers", "6.0.0")
gem("sidekiq", "5.1.3")
gem("devise", "4.4.3")
gem("devise-async", "1.0.0")
gem("groupdate", "4.0.1")
gem("active_record-pool", "2.0.0")
gem("state_machines-activerecord", "0.5.1")
gem("activerecord-like", "2.1")
gem("ar_after_transaction", "0.5.0")
gem("friendly_id", "5.2.4")
gem("strong_migrations", "0.2.3")
gem("ar_transaction_changes", "1.1.3")
gem("goldiloader", "2.1.1")
gem("rein", "3.5.0")
gem("gutentag", "2.4.0")
gem("kaminari", "1.1.1")
gem("money-rails", "1.11.0")
gem("activerecord-safer_migrations", "2.0.0")
gem("migration_data", "0.3.0")
gem("puma_worker_killer", "0.1.0")
gem("pundit", "2.0.0")
gem("redis-objects", "1.4.0")
gem("pry-rails", "0.3.6")
gem("pry-doc", "0.13.4")
gem("jsonapi-serializers", "1.0.1")
gem("jsonapi-realizer", "4.4.0")
gem("jsonapi-home", "1.1.3")
gem("smart_params", "2.3.1")
gem("bugsnag", "6.8.0")
gem("paper_trail", "9.2.0")
gem("action_operation", "2.2.0")
gem("redlock", "0.2.2")
gem("flag_shih_tzu", "0.3.19")
gem("redcarpet", "3.4.0")
gem("google_places", "1.1.0")
gem("bootsnap", "1.3.0", :require => false)

group(:production) do
  gem("rack-timeout", "0.5.1")
  gem("newrelic_rpm", "5.2.0.345")
end

group(:development, :test) do
  gem("dotenv-rails", "2.5.0", :require => "dotenv/rails-now")
  gem("rspec-rails", "3.7.2")
  gem("listen", "3.1.5")
  gem("factory_bot_rails", "4.10.0")
  gem("faker", "1.9.1")
end

group(:test) do
  gem("timecop", "0.9.1")
  gem("rspec-sidekiq", "3.0.3")
  gem("database_cleaner", "1.7.0")
  gem("rspec_junit_formatter", "0.4.1")
end

group(:development) do
  gem("active_record_query_trace", "1.5.4", :require => false)
  gem("brakeman", "4.3.1", :require => false)
  gem("bullet", "5.7.5", :require => false)
  gem("bundler-audit", "0.6.0", :require => false)
  gem("flamegraph", "0.9.5", :require => false)
  gem("memory_profiler", "0.9.11", :require => false)
  gem("rack-mini-profiler", "1.0.0", :require => false)
  gem("rubocop", "0.58.2", :require => false)
  gem("ruby-prof", "0.17.0", :require => false)
  gem("stackprof", "0.2.12", :require => false)
  gem("addressable", "2.5.2", :require => false)
end

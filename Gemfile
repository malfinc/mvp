source("https://rubygems.org")

ruby("2.5.1")

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem("rails", "5.1.4")
gem("administrate", "0.10.0")
gem("sidekiq", "5.1.3")
gem("high_voltage", "3.1.0")
gem("puma", "3.11.4")
gem("puma_worker_killer", "0.1.0")
gem("pg", "0.21.0")
gem("connection_pool", "2.2.2")
gem("oj", "3.6.3")
gem("hiredis", "0.6.1")
gem("active_record-pool", "2.0.0")
gem("activerecord-like", "2.1")
gem("activerecord-safer_migrations", "2.0.0")
gem("ar_after_transaction", "0.5.0")
gem("ar_transaction_changes", "1.1.3")
gem("rein", "3.5.0")
gem("state_machines-activerecord", "0.5.1")
gem("strong_migrations", "0.2.2")
gem("friendly_id", "5.2.4")
gem("goldiloader", "2.1.1")
gem("groupdate", "4.0.1")
gem("gutentag", "2.4.0")
gem("migration_data", "0.3.0")
gem("kaminari", "1.1.1")
gem("bugsnag", "6.7.3")
gem("paper_trail", "9.2.0")
gem("paper_trail-globalid", "0.2.0")
gem("devise", "4.4.3")
gem("devise-async", "1.0.0")
gem("draper", "3.0.1")
gem("money-rails", "1.11.0")
gem("pry-doc", "0.13.4")
gem("pry-rails", "0.3.6")
gem("pundit", "1.1.0")
gem("rack-attack", "5.3.1")
gem("rack-cors", "1.0.2")
gem("redis", "4.0.1")
gem("redis-rails", "5.0.2")
gem("redis-objects", "1.4.0")
gem("redis-rack-cache", "2.0.2")
gem("secure_headers", "6.0.0")
gem("simple_form", "4.0.1")
gem("sitemap_generator", "6.0.1")
gem("sprockets", "3.7.2")
gem("webpacker", "3.5.3")
gem("redcarpet", "3.4.0")
gem("google_places", "1.1.0")
gem("bootsnap", "1.3.0", :require => false)

group :production do
  gem "newrelic_rpm", "5.2.0.345"
  gem "rack-timeout", "0.5.1"
end

group :development, :test do
  gem "byebug", "10.0.2"
  gem "dotenv-rails", "2.5.0", :require => "dotenv/rails-now"
  gem "listen", "3.1.5"
  gem "rspec-rails", "3.7.2"
end

group :test do
  gem "timecop", "0.9.1"
  gem "rspec_junit_formatter", "0.4.1"
end

group :development do
  gem "active_record_query_trace", "1.5.4", :require => false
  gem "brakeman", "4.3.1", :require => false
  gem "bullet", "5.7.5", :require => false
  gem "bundler-audit", "0.6.0", :require => false
  gem "flamegraph", "0.9.5", :require => false
  gem "memory_profiler", "0.9.10", :require => false
  gem "rack-mini-profiler", "1.0.0", :require => false
  gem "rails-callback_log", "0.2.2", :require => false
  gem "rubocop", "0.57.2", :require => false
  gem "ruby-prof", "0.17.0", :require => false
  gem "stackprof", "0.2.11", :require => false
end

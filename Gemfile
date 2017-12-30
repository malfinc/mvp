source 'https://rubygems.org'

ruby '2.4.2'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '5.1.4'
gem 'pg', '0.21.0'
gem 'puma', '3.11.0'
gem 'redis', '4.0.1'
gem 'redis-rails', '5.0.2'
gem 'hiredis', '0.6.1'
gem 'connection_pool', '2.2.1'
gem 'webpacker', '3.0.2'
gem 'sass-rails', '5.0.7'
gem 'draper', '3.0.1'
gem 'strong_migrations', '0.1.9'
gem 'goldiloader', '2.0.1'
gem 'secure_headers', '5.0.3'
gem 'rack-timeout', '0.4.2'
gem 'rack-cors', '1.0.2'
gem 'rack-attack', '5.0.1'
gem 'redis-rack-cache', '2.0.1'
gem 'pry-rails', '0.3.6'
gem 'pry-doc', '0.11.1'
gem 'devise', '4.3.0'
gem 'groupdate', '3.2.0'
gem 'state_machines-activerecord', '0.5.0'
gem 'puma_worker_killer', '0.1.0'
gem 'pundit', '1.1.0'
gem 'newrelic_rpm', '4.6.0.338'
gem 'high_voltage', '3.0.0'
gem 'sitemap_generator', '6.0.0'
gem 'redis-objects', '1.4.0'

group :development, :test do
  gem 'dotenv-rails', '2.2.1', require: 'dotenv/rails-now'
  gem 'byebug', '9.1.0'
  gem 'web-console', '3.5.1'
  gem 'rspec-rails', '3.7.2'
  gem 'listen', '3.1.5'
  gem 'brakeman', '4.0.1', require: false
end

group :development do
  gem 'bundler-audit', '0.6.0'
end

source 'https://rubygems.org'

gem 'rails'
gem 'jquery-rails'

gem 'activeadmin'
gem 'devise_cas_authenticatable'

gem 'just-datetime-picker'

# Gems used for assets generation
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'railties'
  gem 'rails_best_practices'
  gem 'debugger'
end

group :test, :development do
  gem 'sqlite3'
  gem 'rspec-rails'
  # Static analysis for security vulnerabilities.
  gem 'brakeman', :require => false
  gem 'simplecov', :require => false
  gem 'simplecov-html', :require => false
  gem 'simplecov-rcov', :require => false
end

group :test do
  gem 'mocha', :require => false
  gem 'factory_girl_rails'
end

group :production do
  gem 'pg'
end

# Deploy with Capistrano
gem 'capistrano'

gem 'validates_timeliness'


source 'https://rubygems.org'

gem 'rails', '3.2.19'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'bootstrap-sass', '~> 3.1.1'
gem 'hashie'
gem 'pg'
gem 'omniauth-cas'
gem 'wice_grid'
gem 'diff-lcs'
gem 'activeadmin' #unused, but kept because some old migrations depend on it. Remove later.

gem 'daemons'
gem 'delayed_job_active_record'
gem "delayed_job_web"

# Gems used for assets generation
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'railties'
  gem 'rails_best_practices'
end

group :test, :development do
  gem 'sqlite3'
  gem 'rspec-rails'

  gem 'brakeman', :require => false
  gem 'simplecov', :require => false
  gem 'simplecov-html', :require => false
  gem 'simplecov-rcov', :require => false
  gem 'byebug'
end

# Deploy with Capistrano
gem 'capistrano'

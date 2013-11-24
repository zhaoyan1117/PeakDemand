source 'http://rubygems.org'

ruby "1.9.3"

gem 'rails', '3.2.14'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

# for Heroku deployment - as described in Ap. A of ELLS book
group :development, :test do
  gem 'sqlite3'
  gem 'ruby-debug19'
  gem 'database_cleaner'
  gem 'capybara'
  gem 'launchy'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
end

group :test do
  gem 'cucumber-rails', :require => false
  gem 'cucumber-rails-training-wheels'
  gem 'simplecov', :require => false
  gem 'coveralls', :require => false
  gem "webmock", "~> 1.15.2", :require => false
end

group :production do
  gem 'pg'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', '~> 3.2.6'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier'
  gem "twitter-bootstrap-rails"
end

gem 'jquery-rails'
gem 'devise'
gem 'gcal4ruby', :github => 'zhaoyan1117/GCal4Ruby'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

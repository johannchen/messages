source 'http://rubygems.org'

gem 'rails', '3.1.0'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

# postgre
gem 'pg'

# full text search 
# gem 'sunspot_rails'

# pagination
gem 'kaminari'

# authentication
gem 'omniauth', :git => "git://github.com/intridea/omniauth.git", :branch => "0-3-stable"

# authorization
gem 'cancan', '1.6.5'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :development do
  gem 'pry'
end


group :test do
  # Pretty printed test output
  # gem 'turn', :require => false

  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'guard-rspec'
  gem 'libnotify'
  gem 'rb-inotify'
  gem 'spork', '> 0.9.0.rc'
  gem 'guard-spork'
  gem 'launchy'
#  gem 'guard-test'
#  gem 'ruby-prof'
end

gem 'rspec-rails', :group => [:test, :development]

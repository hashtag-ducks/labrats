source 'https://rubygems.org'

gem 'rails', '3.2.14'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg'

group :test, :development do
  gem 'rspec-rails', '~> 2.0'
  gem 'jasmine'
  gem 'guard'
  gem 'guard-rspec', :require => false
  gem 'guard-spork'
end

group :test do
  gem 'capybara', '1.1.2'
  gem 'rake', '10.1.0' # for Travis CI
  gem 'factory_girl_rails', '4.2.1'
  gem 'simplecov', :require => false
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'client_side_validations'

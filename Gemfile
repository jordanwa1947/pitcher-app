source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.4.1'
gem 'rails', '~> 5.2.2'      # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'

gem 'pg', '>= 0.18', '< 2.0' # Use postgresql as the database for Active Record
gem 'puma', '~> 3.11'        # Use Puma as the app server
gem 'sass-rails', '~> 5.0'   # Use SCSS for stylesheets
gem 'uglifier', '>= 1.3.0'   # Use Uglifier as compressor for JavaScript assets
# See https://github.com/rails/execjs#readme for more supported runtimes --- # gem 'mini_racer', platforms: :ruby
gem 'turbolinks'
gem 'coffee-rails', '~> 4.2' # Use CoffeeScript for .coffee assets and views
gem 'jbuilder', '~> 2.5' # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# Use Redis adapter to run Action Cable in production --- # gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password                 --- # gem 'bcrypt', '~> 3.1.7'
# Use ActiveStorage variant                           --- # gem 'mini_magick', '~> 4.8'
# Use Capistrano for deployment                       --- # gem 'capistrano-rails', group: :development
gem 'bootsnap', '>= 1.1.0', require: false  # Reduces boot times through caching; required in config/boot.rb
gem 'bootstrap'
gem 'jquery-rails'
gem 'figaro'
gem 'faraday'
gem 'google-api-client'
gem 'omniauth-google-oauth2'
gem 'geocoder'
gem 'jquery-rails'
gem 'travis'


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  gem 'pry'
  gem 'simplecov'

  gem 'rspec-rails'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'capybara'
  gem 'launchy'
  gem 'webmock'
  gem 'vcr'

  gem 'factory_bot_rails'
  gem 'faker'
  gem 'awesome_print'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

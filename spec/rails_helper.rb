# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production? # Prevent database truncation if the environment is production
# Add additional requires below this line. Rails is not loaded until this point!

require 'rspec/rails'
require 'webmock/rspec'

require 'simplecov'
SimpleCov.start 'rails' do
  add_filter'/bin/'
  add_filter'/db/'
  add_filter'/spec/'
  add_filter'/config/'
  add_filter'/app/channels/'
  add_filter'app/jobs/'
  add_filter'app/mailers/'
  add_filter'app/helpers/'
end

require 'vcr'
VCR.configure do |config|
  config.ignore_localhost = true
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.filter_sensitive_data("<YELP_API_KEY>") { ENV['YELP_API_KEY'] }
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

# Checks for pending migrations and applies them before tests are run. # If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end


require "./spec/fixtures/stubs_for_wishlist"
RSpec.configure do |config|
  config.fixture_path  = "#{::Rails.root}/spec/fixtures" # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.use_transactional_fixtures = true               # If you're not using ActiveRecord, or you'd prefer not to run each of your # examples within a transaction, remove the following line or assign false # instead of true.
  OmniAuth.config.test_mode = true

  Capybara.default_host = 'http://localhost:3000'


  include WishlistStubs

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({
      provider: "google",
      uid: "12345678910",
      info: {
        email: "example@gmail.com",
        first_name: "Jawe",
        last_name: "Some"
      },
      credentials: {
        token: "abcdefg12345",
        refresh_token: "12345abcdefg",
        expires_at: DateTime.now,
      }
    }
    )
  end                                                     # RSpec Rails can automatically mix in different behaviours to your tests based on their file location, for example enabling you to call `get` and `post` in specs under `spec/controllers`. # You can disable this behaviour by removing the line below, and instead explicitly tag your specs with their type, e.g.:
                                                         # The different available types are documented in the features, such as in # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!                    # Filter lines from Rails gems in backtraces. # arbitrary gems may also be filtered via: config.filter_gems_from_backtrace("gem name")
  config.include FactoryBot::Syntax::Methods
end

# OmniAuth.config.test_mode = true
#   omniauth_hash =
# OmniAuth.config.add_mock(:google, omniauth_hash)

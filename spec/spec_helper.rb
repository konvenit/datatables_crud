ENV['RAILS_ENV'] ||= 'test'

require 'rubygems'
require 'bundler/setup'

require File.expand_path("../spec_support/config/environment", __FILE__)
require 'rspec/rails'

load(File.expand_path("../spec_support/config/schema.rb", __FILE__))

RSpec.configure do |config|
  config.before :each do
    I18n.locale = :en
    DatabaseCleaner.start
  end

  config.after :each do
    DatabaseCleaner.clean
  end

  config.run_all_when_everything_filtered = true
  config.treat_symbols_as_metadata_keys_with_true_values = true

  config.use_transactional_fixtures = false
end

require File.expand_path(File.dirname(__FILE__) + "/../lib/datatables_crud")

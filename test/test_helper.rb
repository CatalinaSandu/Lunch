ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'


class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all

(ActiveRecord::Base.connection.tables - %w{schema_migrations}).each do |table_name|
  ActiveRecord::Base.connection.execute "DELETE FROM #{table_name};"
end

  # Add more helper methods to be used by all tests here...
end

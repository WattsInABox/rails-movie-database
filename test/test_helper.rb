ENV["RAILS_ENV"] = "test"
require 'test/unit'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

FactoryGirl.find_definitions

class ActiveSupport::TestCase
end

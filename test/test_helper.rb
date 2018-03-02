ENV['RACK_ENV'] = 'test'
require "minitest/autorun"
require 'rack/test'

require_relative "../application"


require "trailblazer/test/assertions"
require "trailblazer/test/operation/assertions"

require 'database_cleaner'

DatabaseCleaner.strategy = :transaction

Minitest::Spec.class_eval do
  include Trailblazer::Test::Assertions
  include Trailblazer::Test::Operation::Assertions
  include Trailblazer::Test::Operation::Helper

  before :each do
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end
end

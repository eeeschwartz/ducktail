require 'rubygems'
require 'rspec'

RSpec.configure do |config|
  # to maintain color when output redirect to file
  config.tty = true
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

##
# Do not add any code above this line.

##
# Do not add any other code to this code block. Simplecov
# only until the next code block:

if ENV["CI_ENABLE_COVERAGE"]
  require "simplecov/no_defaults"
  require "helpers/simplecov_minitest"

  SimpleCov.start do
    add_filter "/test/"
  end
end

## End Simplecov config

require 'minitest/autorun'
require 'minitest/unit'
require 'minitest/pride'
require 'inspec/resource'
require "inspec/log"

Inspec::Log.logger = Logger.new(nil)

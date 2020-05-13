require 'minitest/autorun'
require 'minitest/unit'
require 'minitest/pride'
require 'inspec/resource'
require "inspec/log"

Inspec::Log.logger = Logger.new(nil)
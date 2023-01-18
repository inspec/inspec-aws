require 'helper'
require 'aws_glue_databases'
require 'aws-sdk-core'

class AWSGlueDatabasesConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSGlueDatabases.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSGlueDatabases.new('rubbish') }
  end

  def test_databases_list_non_existing_for_empty_response
    refute AWSGlueDatabases.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSGlueDatabasesHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_databases
    mock_data = {}
    mock_data[:name] = 'test1'
    mock_data[:description] = 'test1'
    mock_data[:location_uri] = 'test1'
    data[:data] = { :database_list => [mock_data] }
    data[:client] = Aws::Glue::Client
    @database_list = AWSGlueDatabases.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_database_list_exists
    assert @database_list.exist?
  end

  def test_names
    assert_equal(@database_list.names, ['test1'])
  end

  def test_descriptions
    assert_equal(@database_list.descriptions, ['test1'])
  end

  def test_location_uris
    assert_equal(@database_list.location_uris, ['test1'])
  end
end
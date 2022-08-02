require 'helper'
require 'aws_glue_database'
require 'aws-sdk-core'

class AWSGlueDatabaseConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSGlueDatabase.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSGlueDatabase.new(name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSGlueDatabase.new(unexpected: 9) }
  end
end

class AWSGlueDatabaseSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_database
    mock_parameter = {}
    mock_parameter[:name] = 'test1'
    mock_parameter[:description] = 'test1'
    mock_parameter[:location_uri] = 'test1'
    data[:data] = { database: mock_parameter }
    data[:client] = Aws::Glue::Client
    @database = AWSGlueDatabase.new(name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_parameter_group_exists
    assert @database.exists?
  end

  def test_name
    assert_equal(@database.name, 'test1')
  end

  def test_description
    assert_equal(@database.description, 'test1')
  end

  def test_location_uri
    assert_equal(@database.location_uri, 'test1')
  end

  def test_resource_id
    refute_nil(@database.resource_id)
    assert_equal(@database.resource_id, 'test1')
  end
end
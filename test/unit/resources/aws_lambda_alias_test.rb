require 'helper'
require 'aws_lambda_alias'
require 'aws-sdk-core'

class AWSLambdaAliasConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSLambdaAlias.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSLambdaAlias.new(function_name: '', function_alias_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSLambdaAlias.new(unexpected: 9) }
  end
end

class AWSLambdaAliasSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_alias
    mock_data = {}
    mock_data[:alias_arn] = 'test1'
    mock_data[:name] = 'test1'
    mock_data[:function_version] = 'test1'
    mock_data[:description] = 'test1'
    mock_data[:routing_config] = {}
    mock_data[:revision_id] = 'test1'
    data[:data] = [mock_data]
    data[:client] = Aws::Lambda::Client
    @resp = AWSLambdaAlias.new(function_name: 'test1', function_alias_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_alias_exist
    assert @resp.exists?
  end

  def test_alias_arn
    assert_equal(@resp.alias_arn, 'test1')
  end

  def test_name
    assert_equal(@resp.name, 'test1')
  end

  def test_function_version
    assert_equal(@resp.function_version, 'test1')
  end

  def test_description
    assert_equal(@resp.description, 'test1')
  end

  def test_routing_config
    assert_equal(@resp.routing_config, {})
  end

  def test_revision_id
    assert_equal(@resp.revision_id, 'test1')
  end

  def test_resource_id
    refute_nil(@resp.resource_id)
    assert_equal(@resp.resource_id, 'test1')
  end
end

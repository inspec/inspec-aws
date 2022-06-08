require 'helper'
require 'aws_api_gateway_resources'
require 'aws-sdk-core'

class AWSApiGatewayResourcesConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayResources.new(rest_api_id: '', client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayResources.new(rest_api_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSApiGatewayResources.new(unexpected: 9) }
  end
end

class AWSApiGatewayResourcesSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_resources
    mock_data = {}
    mock_data[:id] = 'test_id'
    mock_data[:parent_id] = 'test_parent_id'
    mock_data[:path_part] = 'test_path_part'
    mock_data[:path] = 'test_path'
    mock_data[:resource_methods] = {}
    data[:data] = { :items => [mock_data] }
    data[:client] = Aws::APIGateway::Client
    @res = AWSApiGatewayResources.new(rest_api_id: 'test', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_resources_exists
    assert @res.exists?
  end

  def test_ids
    assert_equal(@res.ids, ['test_id'])
  end

  def test_parent_ids
    assert_equal(@res.parent_ids, ['test_parent_id'])
  end

  def test_path_parts
    assert_equal(@res.path_parts, ['test_path_part'])
  end

  def test_paths
    assert_equal(@res.paths, ['test_path'])
  end

  def test_resource_methods
    assert_equal(@res.resource_methods, [{}])
  end
end

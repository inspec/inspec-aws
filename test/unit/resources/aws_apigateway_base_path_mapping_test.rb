require 'helper'
require 'aws_apigateway_base_path_mapping'
require 'aws-sdk-core'

class AWSApiGatewayBasePathMappingConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayBasePathMapping.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayBasePathMapping.new(domain_name: '', base_path: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSApiGatewayBasePathMapping.new(unexpected: 9) }
  end
end

class AWSApiGatewayBasePathMappingSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_base_path_mapping
    mock_data = {}
    mock_data[:base_path] = 'test1'
    mock_data[:rest_api_id] = 'test1'
    mock_data[:stage] = 'test1'
    data[:data] = [mock_data]
    data[:client] = Aws::APIGateway::Client
    @resp = AWSApiGatewayBasePathMapping.new(domain_name: 'test1', base_path: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_resource_id
    refute_nil(@resp.resource_id)
    assert_equal(@resp.resource_id, 'test1')
  end

  def test_base_path_mapping_exists
    assert @resp.exists?
  end

  def test_base_path
    assert_equal(@resp.base_path, 'test1')
  end

  def test_rest_api_id
    assert_equal(@resp.rest_api_id, 'test1')
  end

  def test_stage
    assert_equal(@resp.stage, 'test1')
  end
end

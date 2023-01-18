require 'helper'
require 'aws_apigateway_base_path_mappings'
require 'aws-sdk-core'

class AWSApiGatewayBasePathMappingsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSApiGatewayBasePathMappings.new(domain_name: 'test1', client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSApiGatewayBasePathMappings.new('rubbish') }
  end

  def test_api_mapping_base_path_mappings_non_existing_for_empty_response
    refute AWSApiGatewayBasePathMappings.new(domain_name: 'test1', client_args: { stub_responses: true }).exist?
  end
end

class AWSApiGatewayBasePathMappingsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_base_path_mappings
    mock_data = {}
    mock_data[:base_path] = 'test1'
    mock_data[:rest_api_id] = 'test1'
    mock_data[:stage] = 'test1'
    data[:data] = { :items => [mock_data] }
    data[:client] = Aws::APIGateway::Client
    @resp = AWSApiGatewayBasePathMappings.new(domain_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_base_paths
    assert_equal(@resp.base_paths, ['test1'])
  end

  def test_rest_api_ids
    assert_equal(@resp.rest_api_ids, ['test1'])
  end

  def test_stages
    assert_equal(@resp.stages, ['test1'])
  end
end

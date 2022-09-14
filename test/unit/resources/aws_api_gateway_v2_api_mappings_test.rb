require 'helper'
require 'aws_api_gateway_v2_api_mappings'
require 'aws-sdk-core'

class AwsApiGatewayV2ApiMappingsConstructorTest < Minitest::Test
  
  def test_empty_params_ok
    AwsApiGatewayV2ApiMappings.new(domain_name: 'test_domain_name', client_args: { stub_responses: true })
  end
end

class AwsApiGatewayV2ApiMappingsHappyPathTest < Minitest::Test
  
  def setup
    data = {}
    data[:method] = :get_api_mappings
    mock_data = {}
    mock_data[:api_id] = 'test_app_id'
    mock_data[:api_mapping_id] = 'test_app_mapping_id'
    mock_data[:api_mapping_key] = 'test_app_mapping_key'
    mock_data[:stage] = 'test_stage'
    data[:data] = { :items => [mock_data] }
    data[:client] = Aws::ApiGatewayV2::Client
    @resp = AwsApiGatewayV2ApiMappings.new(domain_name: 'test_domain_name', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_api_mapping_exists
    assert @resp.exists?
  end

  def test_api_ids
    assert_equal(@resp.api_ids, ['test_app_id'])
  end

  def test_api_mapping_ids
    assert_equal(@resp.api_mapping_ids, ['test_app_mapping_id'])
  end

  def test_api_mapping_keys
    assert_equal(@resp.api_mapping_keys, ['test_app_mapping_key'])
  end

  def test_stages
    assert_equal(@resp.stages, ['test_stage'])
  end
end

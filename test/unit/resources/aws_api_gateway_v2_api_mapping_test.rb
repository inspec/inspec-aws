require 'helper'
require 'aws_api_gateway_v2_api_mapping'
require 'aws-sdk-core'

class AwsApiGatewayV2ApiMappingConstructorTest < Minitest::Test
  
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsApiGatewayV2ApiMapping.new(client_args: { stub_responses: true }) }
  end
  
  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AwsApiGatewayV2ApiMapping.new(api_id: '',  domain_name: '', client_args: { stub_responses: true }) }
  end
  
  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsApiGatewayV2ApiMapping.new(unexpected: 9) }
  end
end

class AwsApiGatewayV2ApiMappingSuccessPathTest < Minitest::Test
  
  def setup
    data = {}
    data[:method] = :get_api_mapping
    mock_data = {}
    mock_data[:api_id] = 'test_app_id'
    mock_data[:api_mapping_id] = 'test_app_mapping_id'
    mock_data[:api_mapping_key] = 'test_app_mapping_key'
    mock_data[:stage] = 'test_stage'
    data[:data] = [mock_data]
    data[:client] = Aws::ApiGatewayV2::Client
    @res = AwsApiGatewayV2ApiMapping.new(api_mapping_id: 'test_app_mapping_id', domain_name: 'test_domain_name', client_args: { stub_responses: true }, stub_data: [data])
  end
  
  def test_resource_id
    refute_nil(@res.resource_id)
    assert_equal(@res.resource_id, @res.api_mapping_id)
  end
  
  def test_api_mapping_exists
    assert @res.exists?
  end
  
  def test_api_id
    assert_equal(@res.api_id, 'test_app_id')
  end
  
  def test_api_mapping_id
    assert_equal(@res.api_mapping_id, 'test_app_mapping_id')
  end
  
  def test_api_mapping_key
    assert_equal(@res.api_mapping_key, 'test_app_mapping_key')
  end
  
  def test_stage
    assert_equal(@res.stage, 'test_stage')
  end
end

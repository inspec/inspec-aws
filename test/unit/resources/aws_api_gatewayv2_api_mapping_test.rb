require 'helper'
require 'aws_api_gatewayv2_api_mapping'
require 'aws-sdk-core'

class AWSApiGatewayV2APIMappingConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayV2APIMapping.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayV2APIMapping.new(api_mapping_id: '', domain_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSApiGatewayV2APIMapping.new(unexpected: 9) }
  end
end

class AWSApiGatewayV2APIMappingSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_api_mapping
    mock_data = {}
    mock_data[:api_id] = 'test1'
    mock_data[:api_mapping_id] = 'test1'
    mock_data[:api_mapping_key] = 'test1'
    mock_data[:stage] = 'test1'
    data[:data] = [mock_data]
    data[:client] = Aws::ApiGatewayV2::Client
    @resp = AWSApiGatewayV2APIMapping.new(api_mapping_id: 'test1', domain_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_api_mapping_exists
    assert @resp.exists?
  end

  def test_api_id
    assert_equal(@resp.api_id, 'test1')
  end

  def test_api_mapping_id
    assert_equal(@resp.api_mapping_id, 'test1')
  end

  def test_api_mapping_key
    assert_equal(@resp.api_mapping_key, 'test1')
  end

  def test_stage
    assert_equal(@resp.stage, 'test1')
  end
end

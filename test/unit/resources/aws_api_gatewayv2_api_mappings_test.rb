require 'helper'
require 'aws_api_gatewayv2_api_mappings'
require 'aws-sdk-core'

class AWSApiGatewayV2APIMappingsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSApiGatewayV2APIMappings.new(domain_name: 'test1', client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSApiGatewayV2APIMappings.new('rubbish') }
  end

  def test_api_mapping_non_existing_for_empty_response
    refute AWSApiGatewayV2APIMappings.new(domain_name: 'test1', client_args: { stub_responses: true }).exist?
  end
end

class AWSApiGatewayV2APIMappingsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_api_mappings
    mock_data = {}
    mock_data[:api_id] = 'test1'
    mock_data[:api_mapping_id] = 'test1'
    mock_data[:api_mapping_key] = 'test1'
    mock_data[:stage] = 'test1'
    data[:data] = { :items => [mock_data] }
    data[:client] = Aws::ApiGatewayV2::Client
    @resp = AWSApiGatewayV2APIMappings.new(domain_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_api_mappings_exists
    assert @resp.exist?
  end

  def test_api_ids
    # require 'byebug'; byebug
    # require 'byebug'; byebug
    assert_equal(@resp.api_ids, ['test1'])

  end

  def test_api_mapping_ids
    assert_equal(@resp.api_mapping_ids, ['test1'])
  end

  def test_api_mapping_keys
    assert_equal(@resp.api_mapping_keys, ['test1'])
  end

  def test_stages
    assert_equal(@resp.stages, ['test1'])
  end
end

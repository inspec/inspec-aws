require 'helper'
require 'aws_apigateway_authorizers'
require 'aws-sdk-core'

class AWSApiGatewayAuthorizersConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSApiGatewayAuthorizers.new(rest_api_id: 'test1', client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSApiGatewayAuthorizers.new('rubbish') }
  end

  def test_api_mapping_authorizers_non_existing_for_empty_response
    refute AWSApiGatewayAuthorizers.new(rest_api_id: 'test1', client_args: { stub_responses: true }).exist?
  end
end

class AWSApiGatewayAuthorizersHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_authorizers
    mock_data = {}
    mock_data[:id] = 'test1'
    mock_data[:name] = 'test1'
    mock_data[:type] = 'test1'
    mock_data[:provider_arns] = ['test1']
    mock_data[:auth_type] = 'test1'
    mock_data[:authorizer_uri] = 'test1'
    mock_data[:authorizer_credentials] = 'test1'
    mock_data[:identity_source] = 'test1'
    mock_data[:identity_validation_expression] = 'test1'
    mock_data[:authorizer_result_ttl_in_seconds] = 1
    data[:data] = { :items => [mock_data] }
    data[:client] = Aws::APIGateway::Client
    @resp = AWSApiGatewayAuthorizers.new(rest_api_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_ids
    assert_equal(@resp.ids, ['test1'])
  end

  def test_names
    assert_equal(@resp.names, ['test1'])
  end

  def test_types
    assert_equal(@resp.types, ['test1'])
  end

  def test_provider_arns
    assert_equal(@resp.provider_arns, [['test1']])
  end

  def test_auth_types
    assert_equal(@resp.auth_types, ['test1'])
  end

  def test_authorizer_uris
    assert_equal(@resp.authorizer_uris, ['test1'])
  end

  def test_authorizer_credentials
    assert_equal(@resp.authorizer_credentials, ['test1'])
  end

  def test_identity_sources
    assert_equal(@resp.identity_sources, ['test1'])
  end

  def test_identity_validation_expressions
    assert_equal(@resp.identity_validation_expressions, ['test1'])
  end

  def test_authorizer_result_ttl_in_seconds
    assert_equal(@resp.authorizer_result_ttl_in_seconds, [1])
  end
end

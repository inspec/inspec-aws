require 'helper'
require 'aws_apigateway_authorizer'
require 'aws-sdk-core'

class AWSApiGatewayAuthorizerConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayAuthorizer.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayAuthorizer.new(rest_api_id: '', authorizer_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSApiGatewayAuthorizer.new(unexpected: 9) }
  end
end

class AWSApiGatewayAuthorizerSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_authorizer
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
    data[:data] = [mock_data]
    data[:client] = Aws::APIGateway::Client
    @resp = AWSApiGatewayAuthorizer.new(rest_api_id: 'test1', authorizer_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_resource_id
    refute_nil(@resp.resource_id)
    assert_equal(@resp.resource_id, 'test1')
  end

  def test_authorizer_exists
    assert @resp.exists?
  end

  def test_id
    assert_equal(@resp.id, 'test1')
  end

  def test_name
    assert_equal(@resp.name, 'test1')
  end

  def test_type
    assert_equal(@resp.type, 'test1')
  end

  def test_provider_arns
    assert_equal(@resp.provider_arns, ['test1'])
  end

  def test_auth_type
    assert_equal(@resp.auth_type, 'test1')
  end

  def test_authorizer_uri
    assert_equal(@resp.authorizer_uri, 'test1')
  end

  def test_authorizer_credentials
    assert_equal(@resp.authorizer_credentials, 'test1')
  end

  def test_identity_source
    assert_equal(@resp.identity_source, 'test1')
  end

  def test_identity_validation_expression
    assert_equal(@resp.identity_validation_expression, 'test1')
  end

  def test_authorizer_result_ttl_in_seconds
    assert_equal(@resp.authorizer_result_ttl_in_seconds, 1)
  end
end

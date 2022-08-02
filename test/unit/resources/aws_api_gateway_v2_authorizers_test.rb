require 'helper'
require 'aws_api_gateway_v2_authorizers'
require 'aws-sdk-core'

class AwsApiGatewayV2AuthorizersConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsApiGatewayV2Authorizers.new(api_id: 'test_api_id', client_args: { stub_responses: true })
  end
end

class AwsApiGatewayV2AuthorizersHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_authorizers
    mock_data = {}
    mock_data[:authorizer_credentials_arn] = 'test_authorizer_credentials_arn'
    mock_data[:authorizer_id] = 'test_authorizer_id'
    mock_data[:authorizer_result_ttl_in_seconds] = 1
    mock_data[:authorizer_type] = 'JWT'
    mock_data[:authorizer_uri] = 'test_authorizer_uri'
    mock_data[:identity_source] = ['test_identity_source']
    mock_data[:identity_validation_expression] = 'test_identity_validation_expression'
    mock_data[:jwt_configuration] = {
      audience: ['test_jwt_configuration_audience'],
      issuer: 'test_jwt_configuration_issuer',
    }
    mock_data[:name] = 'test_name'
    mock_data[:authorizer_payload_format_version] = 'test_authorizer_payload_format_version'
    mock_data[:enable_simple_responses] = true
    data[:data] = { :items => [mock_data] }
    data[:client] = Aws::ApiGatewayV2::Client
    @res = AwsApiGatewayV2Authorizers.new(api_id: 'test_api_id', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_api_authorizer_exists
    assert @res.exists?
  end

  def test_authorizer_credentials_arns
    assert_equal(@res.authorizer_credentials_arns, ['test_authorizer_credentials_arn'])
  end

  def test_authorizer_ids
    assert_equal(@res.authorizer_ids, ['test_authorizer_id'])
  end

  def test_authorizer_result_ttl_in_seconds
    assert_equal(@res.authorizer_result_ttl_in_seconds, [1])
  end

  def test_authorizer_types
    assert_equal(@res.authorizer_types, ['JWT'])
  end

  def test_authorizer_uris
    assert_equal(@res.authorizer_uris, ['test_authorizer_uri'])
  end

  def test_identity_sources
    assert_equal(@res.identity_sources, ['test_identity_source'])
  end

  def test_identity_validation_expressions
    assert_equal(@res.identity_validation_expressions, ['test_identity_validation_expression'])
  end

  def test_names
    assert_equal(@res.names, ['test_name'])
  end

  def test_authorizer_payload_format_versions
    assert_equal(@res.authorizer_payload_format_versions, ['test_authorizer_payload_format_version'])
  end

  def test_enable_simple_responses
    assert_equal(@res.enable_simple_responses, [true])
  end
end

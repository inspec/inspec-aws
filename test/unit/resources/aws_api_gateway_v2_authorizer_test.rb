require 'helper'
require 'aws_api_gateway_v2_authorizer'
require 'aws-sdk-core'

class AwsApiGatewayV2AuthorizerConstructorTest < Minitest::Test
  
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsApiGatewayV2Authorizer.new(api_id: '', authorizer_id: '', client_args: { stub_responses: true }) }
  end
  
  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AwsApiGatewayV2Authorizer.new(api_id: '', authorizer_id: '', client_args: { stub_responses: true }) }
  end
  
  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsApiGatewayV2Authorizer.new(unexpected: 9) }
  end
end

class AwsApiGatewayV2AuthorizerSuccessPathTest < Minitest::Test
  
  def setup
    data = {}
    data[:method] = :get_authorizer
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
    data[:data] = mock_data
    data[:client] = Aws::ApiGatewayV2::Client
    @res = AwsApiGatewayV2Authorizer.new(api_id: 'test_app_id', authorizer_id: 'test_authorizer_id', client_args: { stub_responses: true }, stub_data: [data])
  end
  
  def test_resource_id
    refute_nil(@res.resource_id)
    assert_equal(@res.resource_id, @res.authorizer_id)
  end
  
  def test_api_authorizer_exists
    assert @res.exists?
  end
  
  def test_authorizer_credentials_arn
    assert_equal(@res.authorizer_credentials_arn, 'test_authorizer_credentials_arn')
  end
  
  def test_authorizer_id
    assert_equal(@res.authorizer_id, 'test_authorizer_id')
  end

  def test_authorizer_result_ttl_in_seconds
    assert_equal(@res.authorizer_result_ttl_in_seconds, 1)
  end

  def test_authorizer_type
    assert_equal(@res.authorizer_type, 'JWT')
  end

  def test_authorizer_uri
    assert_equal(@res.authorizer_uri, 'test_authorizer_uri')
  end

  def test_identity_source
    assert_equal(@res.identity_source, ['test_identity_source'])
  end

  def test_identity_validation_expression
    assert_equal(@res.identity_validation_expression, 'test_identity_validation_expression')
  end

  def test_jwt_configuration_audience
    assert_equal(@res.jwt_configuration.audience, ['test_jwt_configuration_audience'])
  end

  def test_jwt_configuration_issuer
    assert_equal(@res.jwt_configuration.issuer, 'test_jwt_configuration_issuer')
  end

  def test_name
    assert_equal(@res.name, 'test_name')
  end

  def test_authorizer_payload_format_version
    assert_equal(@res.authorizer_payload_format_version, 'test_authorizer_payload_format_version')
  end

  def test_enable_simple_responses
    assert_equal(@res.enable_simple_responses, true)
  end
end

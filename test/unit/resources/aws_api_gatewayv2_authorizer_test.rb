require 'helper'
require 'aws_api_gatewayv2_authorizer'
require 'aws-sdk-core'

class AWSApiGatewayV2AuthorizerConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayV2Authorizer.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayV2Authorizer.new(api_id: '',  authorizer_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSApiGatewayV2Authorizer.new(unexpected: 9) }
  end
end

class AWSApiGatewayV2AuthorizerSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_authorizer
    mock_data = {}
    mock_data[:authorizer_credentials_arn] = 'test1'
    mock_data[:authorizer_id] = 'test1'
    mock_data[:authorizer_result_ttl_in_seconds] = 1
    mock_data[:authorizer_type] = 'test1'
    mock_data[:authorizer_uri] = 'test1'
    mock_data[:identity_source] = ['test1']
    mock_data[:jwt_configuration] = {
      audience: ['test1'],
      issuer: 'test1',
    }
    mock_data[:name] = 'test1'
    mock_data[:authorizer_payload_format_version] = 'test1'
    mock_data[:enable_simple_responses] = true
    data[:data] = [mock_data]
    data[:client] = Aws::ApiGatewayV2::Client
    @resp = AWSApiGatewayV2Authorizer.new(api_id: 'test1', authorizer_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_api_exists
    assert @resp.exists?
  end

  def test_authorizer_credentials_arn
    assert_equal(@resp.authorizer_credentials_arn, 'test1')
  end

  def test_authorizer_id
    assert_equal(@resp.authorizer_id, 'test1')
  end

  def test_authorizer_result_ttl_in_seconds
    assert_equal(@resp.authorizer_result_ttl_in_seconds, 1)
  end

  def test_authorizer_type
    assert_equal(@resp.authorizer_type, 'test1')
  end

  def test_authorizer_uri
    assert_equal(@resp.authorizer_uri, 'test1')
  end

  def test_identity_source
    assert_equal(@resp.identity_source, ['test1'])
  end

  def test_audience
    assert_equal(@resp.jwt_configuration.audience, ['test1'])
  end

  def test_issuer
    assert_equal(@resp.jwt_configuration.issuer, 'test1')
  end

  def test_name
    assert_equal(@resp.name, 'test1')
  end

  def test_authorizer_payload_format_version
    assert_equal(@resp.authorizer_payload_format_version, 'test1')
  end

  def test_enable_simple_responses
    assert_equal(@resp.enable_simple_responses, true)
  end
end

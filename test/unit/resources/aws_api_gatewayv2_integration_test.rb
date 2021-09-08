require 'helper'
require 'aws_api_gatewayv2_integration'
require 'aws-sdk-core'

class AWSApiGatewayV2IntegrationConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayV2Integration.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayV2Integration.new(api_id: '', integration_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSApiGatewayV2Integration.new(unexpected: 9) }
  end
end

class AWSApiGatewayV2IntegrationSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_integration
    mock_data = {}
    mock_data[:api_gateway_managed] = true
    mock_data[:connection_id] = 'test1'
    mock_data[:connection_type] = 'test1'
    mock_data[:content_handling_strategy] = 'test1'
    mock_data[:credentials_arn] = 'test1'
    mock_data[:description] = 'test1'
    mock_data[:integration_id] = 'test1'
    mock_data[:integration_method] = 'test1'
    mock_data[:integration_response_selection_expression] = 'test1'
    mock_data[:integration_subtype] = 'test1'
    mock_data[:integration_type] = 'test1'
    mock_data[:integration_uri] = 'test1'
    mock_data[:passthrough_behavior] = 'test1'
    mock_data[:payload_format_version] = 'test1'
    mock_data[:response_parameters] = {}
    mock_data[:template_selection_expression] = 'test1'
    mock_data[:timeout_in_millis] = 1
    mock_data[:tls_config] = { server_name_to_verify: 'test1' }
    data[:data] = [mock_data]
    data[:client] = Aws::ApiGatewayV2::Client
    @resp = AWSApiGatewayV2Integration.new(api_id: 'test1', integration_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_integration_exists
    assert @resp.exists?
  end

  def test_api_gateway_managed
    assert_equal(@resp.api_gateway_managed, true)
  end

  def test_connection_id
    assert_equal(@resp.connection_id, 'test1')
  end

  def test_connection_type
    assert_equal(@resp.connection_type, 'test1')
  end

  def test_content_handling_strategy
    assert_equal(@resp.content_handling_strategy, 'test1')
  end

  def test_credentials_arn
    assert_equal(@resp.credentials_arn, 'test1')
  end

  def test_description
    assert_equal(@resp.description, 'test1')
  end

  def test_integration_id
    assert_equal(@resp.integration_id, 'test1')
  end

  def test_integration_method
    assert_equal(@resp.integration_method, 'test1')
  end

  def test_integration_response_selection_expression
    assert_equal(@resp.integration_response_selection_expression, 'test1')
  end

  def test_integration_subtype
    assert_equal(@resp.integration_subtype, 'test1')
  end

  def test_integration_type
    assert_equal(@resp.integration_type, 'test1')
  end

  def test_integration_uri
    assert_equal(@resp.integration_uri, 'test1')
  end

  def test_passthrough_behavior
    assert_equal(@resp.passthrough_behavior, 'test1')
  end

  def test_payload_format_version
    assert_equal(@resp.payload_format_version, 'test1')
  end

  def test_response_parameters
    assert_equal(@resp.response_parameters, {})
  end

  def test_template_selection_expression
    assert_equal(@resp.template_selection_expression, 'test1')
  end

  def test_timeout_in_millis
    assert_equal(@resp.timeout_in_millis, 1)
  end

  def test_server_name_to_verify
    assert_equal(@resp.tls_config.server_name_to_verify, 'test1')
  end
end

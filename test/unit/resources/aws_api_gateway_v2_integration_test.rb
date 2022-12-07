require 'helper'
require 'aws_api_gateway_v2_integration'
require 'aws-sdk-core'

class AwsApiGatewayV2IntegrationConstructorTest < Minitest::Test
  
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsApiGatewayV2Integration.new(client_args: { stub_responses: true }) }
  end
  
  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) do  AwsApiGatewayV2Integration.new(api_id: '',
                                                                            integration_id: '',
                                                                            integration_response_id: '',
                                                                            client_args: { stub_responses: true })
    end
  end
  
  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsApiGatewayV2Integration.new(unexpected: 9) }
  end
end

class AwsApiGatewayV2IntegrationSuccessPathTest < Minitest::Test
  
  def setup
    data = {}
    data[:method] = :get_integration
    mock_data = {}
    mock_data[:api_gateway_managed] = true
    mock_data[:connection_id] = 'test_connection_id'
    mock_data[:connection_type] = 'INTERNET'
    mock_data[:content_handling_strategy] = 'CONVERT_TO_BINARY'
    mock_data[:credentials_arn] = 'test_credentials_arn'
    mock_data[:description] = 'test_description'
    mock_data[:integration_id] = 'test_integration_id'
    mock_data[:integration_method] = 'test_integration_method'
    mock_data[:integration_response_selection_expression] = 'test_integration_response_selection_expression'
    mock_data[:integration_subtype] = 'test_integration_subtype'
    mock_data[:integration_type] = 'AWS'
    mock_data[:integration_uri] = 'test_integration_uri'
    mock_data[:passthrough_behavior] = 'NEVER'
    mock_data[:payload_format_version] = 'test_payload_format_version'
    mock_data[:request_parameters] = {}
    mock_data[:response_parameters] = {}
    mock_data[:request_templates] = {}
    mock_data[:template_selection_expression] = 'test_template_selection_expression'
    mock_data[:timeout_in_millis] = 10
    mock_data[:tls_config] = {
      server_name_to_verify: 'test_server_name_to_verify'
    }
    data[:data] = [mock_data]
    data[:client] = Aws::ApiGatewayV2::Client
    @res = AwsApiGatewayV2Integration.new(api_id: 'APP_ID',
                                                  integration_id: 'INTEGRATION_ID',
                                                  client_args: { stub_responses: true }, stub_data: [data])
  end
  
  def test_resource_id
    refute_nil(@res.resource_id)
    assert_equal(@res.resource_id, @res.integration_id)
  end
  
  def test_integration_exists
    assert @res.exists?
  end

  def test_api_gateway_managed
    assert_equal(@res.api_gateway_managed, true)
  end

  def test_connection_id
    assert_equal(@res.connection_id, 'test_connection_id')
  end

  def test_connection_type
    assert_equal(@res.connection_type, 'INTERNET')
  end

  def test_content_handling_strategy
    assert_equal(@res.content_handling_strategy, 'CONVERT_TO_BINARY')
  end

  def test_credentials_arn
    assert_equal(@res.credentials_arn, 'test_credentials_arn')
  end

  def test_description
    assert_equal(@res.description, 'test_description')
  end

  def test_integration_id
    assert_equal(@res.integration_id, 'test_integration_id')
  end

  def test_integration_method
    assert_equal(@res.integration_method, 'test_integration_method')
  end

  def test_integration_response_selection_expression
    assert_equal(@res.integration_response_selection_expression, 'test_integration_response_selection_expression')
  end

  def test_integration_subtype
    assert_equal(@res.integration_subtype, 'test_integration_subtype')
  end

  def test_integration_type
    assert_equal(@res.integration_type, 'AWS')
  end

  def test_integration_uri
    assert_equal(@res.integration_uri, 'test_integration_uri')
  end

  def test_passthrough_behavior
    assert_equal(@res.passthrough_behavior, 'NEVER')
  end

  def test_payload_format_version
    assert_equal(@res.payload_format_version, 'test_payload_format_version')
  end

  def test_request_parameters
    assert_equal(@res.request_parameters, {})
  end

  def test_response_parameters
    assert_equal(@res.response_parameters, {})
  end

  def test_request_templates
    assert_equal(@res.request_templates, {})
  end

  def test_template_selection_expression
    assert_equal(@res.template_selection_expression, 'test_template_selection_expression')
  end

  def timeout_in_millis
    assert_equal(@res.timeout_in_millis, 10)
  end

  def test_tls_config_server_name_to_verify
    assert_equal(@res.tls_config.server_name_to_verify, 'test_server_name_to_verify')
  end
end

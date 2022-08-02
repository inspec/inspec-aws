require 'helper'
require 'aws_api_gateway_v2_integrations'
require 'aws-sdk-core'

class AwsApiGatewayV2IntegrationsConstructorTest < Minitest::Test
  
  def test_empty_params_ok
    AwsApiGatewayV2Integrations.new(api_id: 'test_api_id', client_args: { stub_responses: true })
  end
end

class AwsApiGatewayV2IntegrationsHappyPathTest < Minitest::Test
  
  def setup
    data = {}
    data[:method] = :get_integrations
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
    mock_data[:tls_config] = {}
    data[:data] = { :items => [mock_data] }
    data[:client] = Aws::ApiGatewayV2::Client
    @res = AwsApiGatewayV2Integrations.new(api_id: 'test_api_id', client_args: { stub_responses: true }, stub_data: [data])
  end
  
  def test_integration_exists
    assert @res.exists?
  end

  def test_api_gateway_manageds
    assert_equal(@res.api_gateway_manageds, [true])
  end

  def test_connection_ids
    assert_equal(@res.connection_ids, ['test_connection_id'])
  end

  def test_connection_types
    assert_equal(@res.connection_types, ['INTERNET'])
  end

  def test_content_handling_strategies
    assert_equal(@res.content_handling_strategies, ['CONVERT_TO_BINARY'])
  end

  def test_credentials_arns
    assert_equal(@res.credentials_arns, ['test_credentials_arn'])
  end

  def test_descriptions
    assert_equal(@res.descriptions, ['test_description'])
  end

  def test_integration_ids
    assert_equal(@res.integration_ids, ['test_integration_id'])
  end

  def test_integration_methods
    assert_equal(@res.integration_methods, ['test_integration_method'])
  end

  def test_integration_response_selection_expressions
    assert_equal(@res.integration_response_selection_expressions, ['test_integration_response_selection_expression'])
  end

  def test_integration_subtypes
    assert_equal(@res.integration_subtypes, ['test_integration_subtype'])
  end

  def test_integration_types
    assert_equal(@res.integration_types, ['AWS'])
  end

  def test_integration_uris
    assert_equal(@res.integration_uris, ['test_integration_uri'])
  end

  def test_passthrough_behaviors
    assert_equal(@res.passthrough_behaviors, ['NEVER'])
  end

  def test_payload_format_versions
    assert_equal(@res.payload_format_versions, ['test_payload_format_version'])
  end

  def test_request_parameters
    assert_equal(@res.request_parameters, [{}])
  end

  def test_response_parameters
    assert_equal(@res.response_parameters, [{}])
  end

  def test_request_templates
    assert_equal(@res.request_templates, [{}])
  end

  def test_template_selection_expressions
    assert_equal(@res.template_selection_expressions, ['test_template_selection_expression'])
  end

  def timeout_in_millis
    assert_equal(@res.timeout_in_millis, [10])
  end

  def test_tls_configs
    assert_equal(@res.tls_configs, [{}])
  end
end

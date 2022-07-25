require 'helper'
require 'aws_api_gateway_v2_integration_responses'
require 'aws-sdk-core'

class AwsApiGatewayV2IntegrationResponsesConstructorTest < Minitest::Test
  
  def test_empty_params_ok
    AwsApiGatewayV2IntegrationResponses.new(api_id: 'test_api_id', integration_id: 'test_integration_id', client_args: { stub_responses: true })
  end
end

class AwsApiGatewayV2IntegrationResponsesHappyPathTest < Minitest::Test
  
  def setup
    data = {}
    data[:method] = :get_integration_responses
    mock_data = {}
    mock_data[:content_handling_strategy] = 'test_content_handling_strategy'
    mock_data[:integration_response_id] = 'test_integration_response_id'
    mock_data[:integration_response_key] = 'test_integration_response_key'
    mock_data[:response_parameters] = {}
    mock_data[:response_templates] = {}
    mock_data[:template_selection_expression] = 'test_template_selection_expression'
    data[:data] = { :items => [mock_data] }
    data[:client] = Aws::ApiGatewayV2::Client
    @res = AwsApiGatewayV2IntegrationResponses.new(api_id: 'test_api_id', integration_id: 'test_integration_id', client_args: { stub_responses: true }, stub_data: [data])
  end
  
  def test_integration_response_exists
    assert @res.exists?
  end

  def test_content_handling_strategies
    assert_equal(@res.content_handling_strategies, ['test_content_handling_strategy'])
  end

  def test_integration_response_ids
    assert_equal(@res.integration_response_ids, ['test_integration_response_id'])
  end

  def test_integration_response_keys
    assert_equal(@res.integration_response_keys, ['test_integration_response_key'])
  end

  def test_response_parameters
    assert_equal(@res.response_parameters, [{}])
  end

  def test_response_templates
    assert_equal(@res.response_templates, [{}])
  end

  def test_template_selection_expressions
    assert_equal(@res.template_selection_expressions, ['test_template_selection_expression'])
  end
end

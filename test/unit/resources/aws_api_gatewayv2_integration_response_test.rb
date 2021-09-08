require 'helper'
require 'aws_api_gatewayv2_integration_response'
require 'aws-sdk-core'

class AWSApiGatewayV2IntegrationResponseConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayV2IntegrationResponse.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayV2IntegrationResponse.new(api_id: '',  integration_id: '', integration_response_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSApiGatewayV2IntegrationResponse.new(unexpected: 9) }
  end
end

class AWSApiGatewayV2IntegrationResponseSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_integration_response
    mock_data = {}
    mock_data[:content_handling_strategy] = 'test1'
    mock_data[:integration_response_id] = 'test1'
    mock_data[:integration_response_key] = 'test1'
    mock_data[:response_parameters] = {}
    mock_data[:response_templates] = {}
    mock_data[:template_selection_expression] = 'test1'
    data[:data] = [mock_data]
    data[:client] = Aws::ApiGatewayV2::Client
    @resp = AWSApiGatewayV2IntegrationResponse.new(api_id: 'test1', integration_id: 'test1', integration_response_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_integration_response_exists
    assert @resp.exists?
  end

  def test_content_handling_strategy
    assert_equal(@resp.content_handling_strategy, 'test1')
  end

  def test_integration_response_id
    assert_equal(@resp.integration_response_id, 'test1')
  end

  def test_integration_response_key
    assert_equal(@resp.integration_response_key, 'test1')
  end

  def test_response_parameters
    assert_equal(@resp.response_parameters, {})
  end

  def test_response_templates
    assert_equal(@resp.response_templates, {})
  end

  def test_template_selection_expression
    assert_equal(@resp.template_selection_expression, 'test1')
  end
end

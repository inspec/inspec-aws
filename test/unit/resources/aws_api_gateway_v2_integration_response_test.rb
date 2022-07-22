require 'helper'
require 'aws_api_gateway_v2_integration_response'
require 'aws-sdk-core'

class AwsApiGatewayV2IntegrationResponseConstructorTest < Minitest::Test
  
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsApiGatewayV2IntegrationResponse.new(client_args: { stub_responses: true }) }
  end
  
  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) do  AwsApiGatewayV2IntegrationResponse.new(api_id: '',
                                                                            integration_id: '',
                                                                            integration_response_id: '',
                                                                            client_args: { stub_responses: true })
    end
  end
  
  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsApiGatewayV2IntegrationResponse.new(unexpected: 9) }
  end
end

class AwsApiGatewayV2IntegrationResponseSuccessPathTest < Minitest::Test
  
  def setup
    data = {}
    data[:method] = :get_integration_response
    mock_data = {}
    mock_data[:content_handling_strategy] = 'test_content_handling_strategy'
    mock_data[:integration_response_id] = 'test_integration_response_id'
    mock_data[:integration_response_key] = 'test_integration_response_key'
    mock_data[:response_parameters] = {}
    mock_data[:response_templates] = {}
    mock_data[:template_selection_expression] = 'test_template_selection_expression'
    data[:data] = [mock_data]
    data[:client] = Aws::ApiGatewayV2::Client
    @res = AwsApiGatewayV2IntegrationResponse.new(api_id: 'APP_ID',
                                                  integration_id: 'INTEGRATION_ID',
                                                  integration_response_id: 'INTEGRATION_RESPONSE_ID',
                                                  client_args: { stub_responses: true }, stub_data: [data])
  end
  
  def test_resource_id
    refute_nil(@res.resource_id)
    assert_equal(@res.resource_id, @res.integration_response_id)
  end
  
  def test_integration_response_exists
    assert @res.exists?
  end

  def test_content_handling_strategy
    assert_equal(@res.content_handling_strategy, 'test_content_handling_strategy')
  end

  def test_integration_response_id
    assert_equal(@res.integration_response_id, 'test_integration_response_id')
  end

  def test_integration_response_key
    assert_equal(@res.integration_response_key, 'test_integration_response_key')
  end

  def test_response_parameters
    assert_equal(@res.response_parameters, {})
  end

  def test_response_templates
    assert_equal(@res.response_templates, {})
  end

  def test_template_selection_expression
    assert_equal(@res.template_selection_expression, 'test_template_selection_expression')
  end
end

require 'helper'
require 'aws_api_gateway_v2_route'
require 'aws-sdk-core'

class AwsApiGatewayV2RouteConstructorTest < Minitest::Test
  
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsApiGatewayV2Route.new(client_args: { stub_responses: true }) }
  end
  
  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) do  AwsApiGatewayV2Route.new(api_id: '', route_id: '', client_args: { stub_responses: true })
    end
  end
  
  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsApiGatewayV2Route.new(unexpected: 9) }
  end
end

class AwsApiGatewayV2RouteSuccessPathTest < Minitest::Test
  
  def setup
    data = {}
    data[:method] = :get_route
    mock_data = {}
    mock_data[:api_gateway_managed] = true
    mock_data[:api_key_required] = true
    mock_data[:authorization_scopes] = ['test_authorization_scopes']
    mock_data[:authorization_type] = 'JWT'
    mock_data[:authorizer_id] = 'test_authorizer_id'
    mock_data[:model_selection_expression] = 'test_model_selection_expression'
    mock_data[:operation_name] = 'test_operation_name'
    mock_data[:request_models] = {}
    mock_data[:request_parameters] = {}
    mock_data[:route_id] = 'test_route_id'
    mock_data[:route_key] = 'test_route_key'
    mock_data[:route_response_selection_expression] = 'test_route_response_selection_expression'
    mock_data[:target] = 'test_target'
    data[:data] = [mock_data]
    data[:client] = Aws::ApiGatewayV2::Client
    @res = AwsApiGatewayV2Route.new(api_id: 'APP_ID', route_id: 'ROUTE_ID', client_args: { stub_responses: true }, stub_data: [data])
  end
  
  def test_resource_id
    refute_nil(@res.resource_id)
    assert_equal(@res.resource_id, @res.route_id)
  end
  
  def test_route_exists
    assert @res.exists?
  end

  def test_api_gateway_managed
    assert_equal(@res.api_gateway_managed, true)
  end

  def test_api_key_required
    assert_equal(@res.api_key_required, true)
  end

  def test_authorization_scopes
    assert_equal(@res.authorization_scopes, ['test_authorization_scopes'])
  end

  def test_authorization_type
    assert_equal(@res.authorization_type, 'JWT')
  end

  def test_authorizer_id
    assert_equal(@res.authorizer_id, 'test_authorizer_id')
  end

  def test_model_selection_expression
    assert_equal(@res.model_selection_expression, 'test_model_selection_expression')
  end

  def test_operation_name
    assert_equal(@res.operation_name, 'test_operation_name')
  end

  def test_request_models
    assert_equal(@res.request_models, {})
  end

  def test_request_parameters
    assert_equal(@res.request_parameters, {})
  end

  def test_route_id
    assert_equal(@res.route_id, 'test_route_id')
  end

  def test_route_key
    assert_equal(@res.route_key, 'test_route_key')
  end

  def test_route_response_selection_expression
    assert_equal(@res.route_response_selection_expression, 'test_route_response_selection_expression')
  end

  def test_target
    assert_equal(@res.target, 'test_target')
  end
end

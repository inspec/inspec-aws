require 'helper'
require 'aws_api_gatewayv2_route'
require 'aws-sdk-core'

class AWSApiGatewayV2RouteConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayV2Route.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayV2Route.new(api_id: '', route_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSApiGatewayV2Route.new(unexpected: 9) }
  end
end

class AWSApiGatewayV2RouteSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_route
    mock_data = {}
    mock_data[:api_gateway_managed] = true
    mock_data[:api_key_required] = true
    mock_data[:authorization_scopes] = ['test1']
    mock_data[:authorization_type] = 'test1'
    mock_data[:authorizer_id] = 'test1'
    mock_data[:model_selection_expression] = 'test1'
    mock_data[:operation_name] = 'test1'
    mock_data[:request_models] = {}
    mock_data[:request_parameters] = {}
    mock_data[:route_id] = 'test1'
    mock_data[:route_key] = 'test1'
    mock_data[:route_response_selection_expression] = 'test1'
    mock_data[:target] = 'test1'
    data[:data] = [mock_data]
    data[:client] = Aws::ApiGatewayV2::Client
    @resp = AWSApiGatewayV2Route.new(api_id: 'test1', route_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_route_exists
    assert @resp.exists?
  end

  def test_api_gateway_managed
    assert_equal(@resp.api_gateway_managed, true)
  end

  def test_api_key_required
    assert_equal(@resp.api_key_required, true)
  end

  def test_authorization_scopes
    assert_equal(@resp.authorization_scopes, ['test1'])
  end

  def test_authorization_type
    assert_equal(@resp.authorization_type, 'test1')
  end

  def test_model_selection_expression
    assert_equal(@resp.model_selection_expression, 'test1')
  end

  def test_operation_name
    assert_equal(@resp.operation_name, 'test1')
  end

  def test_request_models
    assert_equal(@resp.request_models, {})
  end

  def test_request_parameters
    assert_equal(@resp.request_parameters, {})
  end

  def test_route_id
    assert_equal(@resp.route_id, 'test1')
  end

  def test_route_key
    assert_equal(@resp.route_key, 'test1')
  end

  def test_route_response_selection_expression
    assert_equal(@resp.route_response_selection_expression, 'test1')
  end

  def test_target
    assert_equal(@resp.target, 'test1')
  end
end

require 'helper'
require 'aws_api_gateway_v2_routes'
require 'aws-sdk-core'

class AwsApiGatewayV2RoutesConstructorTest < Minitest::Test
  
  def test_empty_params_ok
    AwsApiGatewayV2Routes.new(api_id: 'test_api_id', client_args: { stub_responses: true })
  end
end

class AwsApiGatewayV2RoutesHappyPathTest < Minitest::Test
  
  def setup
    data = {}
    data[:method] = :get_routes
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
    data[:data] = { :items => [mock_data] }
    data[:client] = Aws::ApiGatewayV2::Client
    @res = AwsApiGatewayV2Routes.new(api_id: 'test_api_id', client_args: { stub_responses: true }, stub_data: [data])
  end
  
  def test_route_exists
    assert @res.exists?
  end

  def test_api_gateway_manageds
    assert_equal(@res.api_gateway_manageds, [true])
  end

  def test_api_key_requireds
    assert_equal(@res.api_key_requireds, [true])
  end

  def test_authorization_scopes
    assert_equal(@res.authorization_scopes, ['test_authorization_scopes'])
  end

  def test_authorization_types
    assert_equal(@res.authorization_types, ['JWT'])
  end

  def test_authorizer_ids
    assert_equal(@res.authorizer_ids, ['test_authorizer_id'])
  end

  def test_model_selection_expressions
    assert_equal(@res.model_selection_expressions, ['test_model_selection_expression'])
  end

  def test_operation_names
    assert_equal(@res.operation_names, ['test_operation_name'])
  end

  def test_request_models
    assert_equal(@res.request_models, [{}])
  end

  def test_request_parameters
    assert_equal(@res.request_parameters, [{}])
  end

  def test_route_ids
    assert_equal(@res.route_ids, ['test_route_id'])
  end

  def test_route_keys
    assert_equal(@res.route_keys, ['test_route_key'])
  end

  def test_route_response_selection_expressions
    assert_equal(@res.route_response_selection_expressions, ['test_route_response_selection_expression'])
  end

  def test_targets
    assert_equal(@res.targets, ['test_target'])
  end
end

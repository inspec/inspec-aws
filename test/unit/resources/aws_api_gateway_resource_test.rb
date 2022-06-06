require 'helper'
require 'aws_api_gateway_resource'
require 'aws-sdk-core'

class AWSApiGatewayResourceConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayResource.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayResource.new(rest_api_id: '', resource_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSApiGatewayResource.new(unexpected: 9) }
  end
end

class AWSApiGatewayResourceSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_resource
    mock_data = {}
    mock_data[:id] = 'test_id'
    mock_data[:parent_id] = 'test_parent_id'
    mock_data[:path_part] = 'test_path_part'
    mock_data[:path] = 'test_path'
    mock_data[:resource_methods] = {
      http_method: 'test_http_method',
      authorization_type: 'test_authorization_type',
      authorizer_id: 'test_authorizer_id',
      api_key_required: true,
      request_validator_id: 'test_request_validator_id',
      operation_name: 'test_operation_name',
      # request_parameters: 'test_request_parameters',
      # request_models: 'test_request_models',
      method_responses: {
        status_code: 'test_status_code',
        # response_parameters: true,
        # response_models: true,
      },
      method_integration: {
        type: 'test_type',
        http_method: 'test_http_method',
        uri: 'test_uri',
        connection_type: 'test_connection_type',
        connection_id: 'test_connection_id',
        credentials: 'test_credentials',
        # request_parameters: 'test_',
        # request_templates: 'test_',
        passthrough_behavior: 'test_passthrough_behavior',
        content_handling: 'test_content_handling',
        timeout_in_millis: 10,
        cache_namespace: 'test_cache_namespace',
        cache_key_parameters: 'test_cache_key_parameters',
        integration_responses: {
          status_code: 'test_status_code',
          selection_pattern: 'test_selection_pattern',
          # response_parameters: 'test_response_parameters',
          # response_templates: 'test_response_templates',
          content_handling: 'test_content_handling',
        },
        tls_config: {
          insecure_skip_verification: true
        }
      }
      # authorization_scopes: 'test_',
    }
    data[:data] = [mock_data]
    data[:client] = Aws::APIGateway::Client
    @res = AWSApiGatewayResource.new(rest_api_id: 'test_rest_api_id', resource_id: 'test_resource_id', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_resource_exists
    assert @res.exists?
  end

  def test_id
    require 'pry'; binding.pry
    assert_equal(@res.id, 'test')
  end

  def test_parent_id
    assert_equal(@res.parent_id, 'test')
  end

  def test_path_part
    assert_equal(@res.path_part, 'test')
  end

  def test_path
    assert_equal(@res.path, 'test')
  end

  def test_resource_methods
    assert_equal(@res.resource_methods, {})
  end
end

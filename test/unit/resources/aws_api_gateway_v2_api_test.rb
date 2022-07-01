require 'helper'
require 'aws_api_gateway_v2_api'
require 'aws-sdk-core'

class AwsApiGatewayV2ApiConstructorTest < Minitest::Test
  
  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsApiGatewayV2Api.new(client_args: { stub_responses: true }) }
  end
  
  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AwsApiGatewayV2Api.new(api_id: '', client_args: { stub_responses: true }) }
  end
  
  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsApiGatewayV2Api.new(unexpected: 9) }
  end
end

class AwsApiGatewayV2ApiSuccessPathTest < Minitest::Test
  
  def setup
    data = {}
    data[:method] = :get_api
    mock_data = {}
    mock_data[:api_endpoint] = 'test_endpoint'
    mock_data[:api_gateway_managed] = true
    mock_data[:api_id] = 'test_app_id'
    mock_data[:api_key_selection_expression] = 'test_key_selection_expression'
    mock_data[:cors_configuration] = {}
    mock_data[:created_date] = Time.parse('2021-01-19 06:26:13.000000000 +0000')
    mock_data[:description] = 'test_description'
    mock_data[:disable_schema_validation] = true
    mock_data[:disable_execute_api_endpoint] = true
    mock_data[:import_info] = ['test_import_info']
    mock_data[:name] = 'test_name'
    mock_data[:protocol_type] = 'HTTP'
    mock_data[:route_selection_expression] = 'test_route_selection_expression'
    mock_data[:tags] = {}
    mock_data[:version] = 'test_version'
    mock_data[:warnings] = ['test_warnings']
    data[:data] = [mock_data]
    data[:client] = Aws::ApiGatewayV2::Client
    @res = AwsApiGatewayV2Api.new(api_id: 'test_app_id', client_args: { stub_responses: true }, stub_data: [data])
  end
  
  def test_resource_id
    refute_nil(@res.resource_id)
    assert_equal(@res.resource_id, @res.api_endpoint)
  end
  
  def test_api_exists
    assert @res.exists?
  end
  
  def test_api_endpoint
    assert_equal(@res.api_endpoint, 'test_endpoint')
  end
  
  def test_api_gateway_managed
    assert_equal(@res.api_gateway_managed, true)
  end

  def test_api_id
    assert_equal(@res.api_id, 'test_app_id')
  end

  def test_api_key_selection_expression
    assert_equal(@res.api_key_selection_expression, 'test_key_selection_expression')
  end
  
  def test_cors_configuration
    assert_equal(@res.cors_configuration, {})
  end
  
  def test_created_date
    assert_equal(@res.created_date, Time.parse('2021-01-19 06:26:13.000000000 +0000'))
  end

  def test_description
    assert_equal(@res.description, 'test_description')
  end

  def test_disable_schema_validation
    assert_equal(@res.disable_schema_validation, true)
  end

  def test_disable_execute_api_endpoint
    assert_equal(@res.disable_execute_api_endpoint, true)
  end

  def test_import_info
    assert_equal(@res.import_info, ['test_import_info'])
  end

  def test_name
    assert_equal(@res.name, 'test_name')
  end

  def test_protocol_type
    assert_equal(@res.protocol_type, 'HTTP')
  end

  def test_route_selection_expression
    assert_equal(@res.route_selection_expression, 'test_route_selection_expression')
  end

  def test_tags
    assert_equal(@res.tags, {})
  end

  def test_version
    assert_equal(@res.version, 'test_version')
  end

  def test_warnings
    assert_equal(@res.warnings, ['test_warnings'])
  end
end

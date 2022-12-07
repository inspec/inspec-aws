require 'helper'
require 'aws_api_gateway_v2_apis'
require 'aws-sdk-core'

class AwsApiGatewayV2ApisConstructorTest < Minitest::Test
  
  def test_empty_params_ok
    AwsApiGatewayV2Apis.new(client_args: { stub_responses: true })
  end
  
  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsApiGatewayV2Apis.new('rubbish') }
  end
  
  def test_apis_non_existing_for_empty_response
    refute AwsApiGatewayV2Apis.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsApiGatewayV2ApisSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_apis
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
    data[:data] = { :items => [mock_data] }
    data[:client] = Aws::ApiGatewayV2::Client
    @res = AwsApiGatewayV2Apis.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_api_exists
    assert @res.exists?
  end

  def test_api_endpoints
    assert_equal(@res.api_endpoints, ['test_endpoint'])
  end

  def test_api_ids
    assert_equal(@res.api_ids, ['test_app_id'])
  end

  def test_api_key_selection_expressions
    assert_equal(@res.api_key_selection_expressions, ['test_key_selection_expression'])
  end

  def test_cors_configurations
    assert_equal(@res.cors_configurations, [{}])
  end

  def test_created_dates
    assert_equal(@res.created_dates, [Time.parse('2021-01-19 06:26:13.000000000 +0000')])
  end

  def test_descriptions
    assert_equal(@res.descriptions, ['test_description'])
  end

  def test_disable_schema_validations
    assert_equal(@res.disable_schema_validations, [true])
  end

  def test_disable_execute_api_endpoints
    assert_equal(@res.disable_execute_api_endpoints, [true])
  end

  def test_import_infos
    assert_equal(@res.import_infos, ['test_import_info'])
  end

  def test_names
    assert_equal(@res.names, ['test_name'])
  end

  def test_protocol_types
    assert_equal(@res.protocol_types, ['HTTP'])
  end

  def test_route_selection_expressions
    assert_equal(@res.route_selection_expressions, ['test_route_selection_expression'])
  end

  def test_tags
    assert_equal(@res.tags, [{}])
  end

  def test_versions
    assert_equal(@res.versions, ['test_version'])
  end

  def test_warnings
    assert_equal(@res.warnings, ['test_warnings'])
  end
end

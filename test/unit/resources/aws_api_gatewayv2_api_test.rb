require 'helper'
require 'aws_api_gatewayv2_api'
require 'aws-sdk-core'

class AWSApiGatewayV2APIConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayV2API.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayV2API.new(api_id: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSApiGatewayV2API.new(unexpected: 9) }
  end
end

class AWSApiGatewayV2APISuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_api
    mock_data = {}
    mock_data[:api_endpoint] = 'test1'
    mock_data[:api_gateway_managed] = true
    mock_data[:api_id] = 'test1'
    mock_data[:api_key_selection_expression] = 'test1'
    mock_data[:cors_configuration] = {
      allow_credentials: true,
      allow_headers: ['test1'],
      allow_methods: ['test1'],
      allow_origins: ['test1'],
      expose_headers: ['test1'],
      max_age: 1
    }
    mock_data[:created_date] = Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_data[:description] = 'test1'
    mock_data[:disable_schema_validation] = true
    mock_data[:disable_execute_api_endpoint] = true
    mock_data[:import_info] = ['test1']
    mock_data[:name] = 'test1'
    mock_data[:protocol_type] = 'test1'
    mock_data[:route_selection_expression] = 'test1'
    mock_data[:version] = 'test1'
    mock_data[:warnings] = ['test1']
    data[:data] = [mock_data]
    data[:client] = Aws::ApiGatewayV2::Client
    @resp = AWSApiGatewayV2API.new(api_id: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_api_exists
    assert @resp.exists?
  end

  def test_api_endpoint
    assert_equal(@resp.api_endpoint, 'test1')
  end

  def test_api_gateway_managed
    assert_equal(@resp.api_gateway_managed, true)
  end

  def test_api_id
    assert_equal(@resp.api_id, 'test1')
  end

  def test_api_key_selection_expression
    assert_equal(@resp.api_key_selection_expression, 'test1')
  end

  def test_allow_credentials
    assert_equal(@resp.cors_configuration.allow_credentials, true)
  end

  def test_allow_headers
    assert_equal(@resp.cors_configuration.allow_headers, ['test1'])
  end

  def test_allow_methods
    assert_equal(@resp.cors_configuration.allow_methods, ['test1'])
  end

  def test_allow_origins
    assert_equal(@resp.cors_configuration.allow_origins, ['test1'])
  end

  def test_expose_headers
    assert_equal(@resp.cors_configuration.expose_headers, ['test1'])
  end

  def test_max_age
    assert_equal(@resp.cors_configuration.max_age, 1)
  end

  def test_created_date
    assert_equal(@resp.created_date, Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end

  def test_description
    assert_equal(@resp.description, 'test1')
  end

  def test_disable_schema_validation
    assert_equal(@resp.disable_schema_validation, true)
  end

  def test_disable_execute_api_endpoint
    assert_equal(@resp.disable_execute_api_endpoint, true)
  end

  def test_import_info
    assert_equal(@resp.import_info, ['test1'])
  end

  def test_name
    assert_equal(@resp.name, 'test1')
  end

  def test_protocol_type
    assert_equal(@resp.protocol_type, 'test1')
  end

  def test_route_selection_expression
    assert_equal(@resp.route_selection_expression, 'test1')
  end

  def test_version
    assert_equal(@resp.version, 'test1')
  end

  def test_warnings
    assert_equal(@resp.warnings, ['test1'])
  end
end

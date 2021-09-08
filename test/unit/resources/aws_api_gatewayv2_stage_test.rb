require 'helper'
require 'aws_api_gatewayv2_stage'
require 'aws-sdk-core'

class AWSApiGatewayV2StageConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayV2Stage.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSApiGatewayV2Stage.new(api_id: '', stage_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSApiGatewayV2Stage.new(unexpected: 9) }
  end
end

class AWSApiGatewayV2StageSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_stage
    mock_data = {}
    mock_data[:access_log_settings] = {
      destination_arn: 'test1',
      format: 'test1'
    }
    mock_data[:api_gateway_managed] = true
    mock_data[:auto_deploy] = true
    mock_data[:client_certificate_id] = 'test1'
    mock_data[:created_date] = Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_data[:default_route_settings] = {
      data_trace_enabled: true,
      detailed_metrics_enabled: true,
      logging_level: 'test1',
      throttling_burst_limit: 1,
    }
    mock_data[:deployment_id] = 'test1'
    mock_data[:description] = 'test1'
    mock_data[:last_deployment_status_message] = 'test1'
    mock_data[:last_updated_date] = Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00")
    mock_data[:route_settings] = {}
    mock_data[:stage_name] = 'test1'
    mock_data[:stage_variables] = {}
    mock_data[:tags] = {}
    data[:data] = [mock_data]
    data[:client] = Aws::ApiGatewayV2::Client
    @resp = AWSApiGatewayV2Stage.new(api_id: 'test1', stage_name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_stage_name_exists
    assert @resp.exists?
  end

  def test_access_log_settings_destination_arn
    assert_equal(@resp.access_log_settings.destination_arn, 'test1')
  end

  def test_access_log_settings_format
    assert_equal(@resp.access_log_settings.format, 'test1')
  end

  def test_api_gateway_managed
    assert_equal(@resp.api_gateway_managed, true)
  end

  def test_auto_deploy
    assert_equal(@resp.auto_deploy, true)
  end

  def test_client_certificate_id
    assert_equal(@resp.client_certificate_id, 'test1')
  end

  def test_created_date
    assert_equal(@resp.created_date, Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end

  def test_data_trace_enabled
    assert_equal(@resp.default_route_settings.data_trace_enabled, true)
  end

  def test_detailed_metrics_enabled
    assert_equal(@resp.default_route_settings.detailed_metrics_enabled, true)
  end

  def test_logging_level
    assert_equal(@resp.default_route_settings.logging_level, 'test1')
  end

  def test_throttling_burst_limit
    assert_equal(@resp.default_route_settings.throttling_burst_limit, 1)
  end

  def test_client_certificate_id
    assert_equal(@resp.client_certificate_id, 'test1')
  end

  def test_description
    assert_equal(@resp.description, 'test1')
  end

  def test_deployment_id
    assert_equal(@resp.deployment_id, 'test1')
  end

  def test_last_updated_date
    assert_equal(@resp.last_updated_date, Time.parse("2013-06-11T23:52:02Z2020-06-05T11:30:39.730000+01:00"))
  end

  def test_route_settings
    assert_equal(@resp.route_settings, {})
  end

  def test_stage_name
    assert_equal(@resp.stage_name, 'test1')
  end

  def test_stage_variables
    assert_equal(@resp.stage_variables, {})
  end

  def test_tags
    assert_equal(@resp.tags, {})
  end
end

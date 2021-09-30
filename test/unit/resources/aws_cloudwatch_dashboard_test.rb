require 'helper'
require 'aws_cloudwatch_dashboard'
require 'aws-sdk-core'

class AWSCloudwatchDashboardConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSCloudwatchDashboard.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSCloudwatchDashboard.new(dashboard_name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSCloudwatchDashboard.new(unexpected: 9) }
  end
end

class AWSCloudwatchDashboardHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_dashboard
    mock_cloudwatch_dashboards = {}
    mock_cloudwatch_dashboards[:dashboard_name] = 'test-name'
    mock_cloudwatch_dashboards[:dashboard_arn] = 'test-arn'
    mock_cloudwatch_dashboards[:dashboard_body] = "test-body"
    data[:data] = mock_cloudwatch_dashboards
    data[:client] = Aws::CloudWatch::Client
    @resp = AWSCloudwatchDashboard.new(dashboard_name: 'test1' , client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_dashboard_exists
    assert @resp.exist?
  end

  def test_dashboard_name
    assert_equal(@resp.dashboard_name, 'test-name')
  end

  def test_dashboard_arn
    assert_equal(@resp.dashboard_arn, 'test-arn')
  end
end
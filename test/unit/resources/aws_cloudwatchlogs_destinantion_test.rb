require 'helper'
require 'aws_cloudwatchlogs_destinantion'
require 'aws-sdk-core'

class AWSCloudWatchLogsDestinationConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AWSCloudWatchLogsDestination.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AWSCloudWatchLogsDestination.new(destination_name_prefix: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AWSCloudWatchLogsDestination.new(unexpected: 9) }
  end
end

class AWSCloudWatchLogsDestinationSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_destinations
    mock_parameter = {}
    mock_parameter[:destination_name] = 'test1'
    mock_parameter[:target_arn] = 'test1'
    mock_parameter[:role_arn] = 'test1'
    mock_parameter[:access_policy] = 'test1'
    mock_parameter[:arn] = 'test1'
    data[:data] = { destinations: [mock_parameter] }
    data[:client] = Aws::CloudWatchLogs::Client
    @resp = AWSCloudWatchLogsDestination.new(destination_name_prefix: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_destination_exists
    assert @resp.exists?
  end

  def test_destination_name
    assert_equal(@resp.destination_name, 'test1')
  end

  def test_target_arn
    assert_equal(@resp.target_arn, 'test1')
  end

  def test_role_arn
    assert_equal(@resp.role_arn, 'test1')
  end

  def test_access_policy
    assert_equal(@resp.access_policy, 'test1')
  end

  def test_arn
    assert_equal(@resp.arn, 'test1')
  end
end
require 'helper'
require 'aws_cloudwatchlogs_destinantions'
require 'aws-sdk-core'

class AWSCloudWatchLogsDestinationsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AWSCloudWatchLogsDestinations.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AWSCloudWatchLogsDestinations.new('rubbish') }
  end

  def test_destinations_non_existing_for_empty_response
    refute AWSCloudWatchLogsDestinations.new(client_args: { stub_responses: true }).exist?
  end
end

class AWSCloudWatchLogsDestinationsHappyPathTest < Minitest::Test

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
    @resp = AWSCloudWatchLogsDestinations.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_destination_exists
    assert @resp.exists?
  end

  def test_destination_name
    assert_equal(@resp.destination_names, ['test1'])
  end

  def test_target_arn
    assert_equal(@resp.target_arns, ['test1'])
  end

  def test_role_arn
    assert_equal(@resp.role_arns, ['test1'])
  end

  def test_access_policy
    assert_equal(@resp.access_policies, ['test1'])
  end

  def test_arn
    assert_equal(@resp.arns, ['test1'])
  end
end
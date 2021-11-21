require 'helper'
require 'aws_cloudfront_realtime_log_config'
require 'aws-sdk-core'

class AwsCloudFrontRealtimeLogConfigConstructorTest < Minitest::Test

  def test_empty_params_not_ok
    assert_raises(ArgumentError) { AwsCloudFrontRealtimeLogConfig.new(client_args: { stub_responses: true }) }
  end

  def test_empty_param_arg_not_ok
    assert_raises(ArgumentError) { AwsCloudFrontRealtimeLogConfig.new(name: '', client_args: { stub_responses: true }) }
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsCloudFrontRealtimeLogConfig.new(unexpected: 9) }
  end
end

class AwsCloudFrontRealtimeLogConfigSuccessPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :get_realtime_log_config
    mock_data = {}
    mock_data[:arn] = 'test1'
    mock_data[:name] = 'test1'
    mock_data[:sampling_rate] = 1
    mock_data[:end_points] = []
    mock_data[:fields] = []
    data[:data] = { realtime_log_config: mock_data }
    data[:client] = Aws::CloudFront::Client
    @resp = AwsCloudFrontRealtimeLogConfig.new(name: 'test1', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_realtime_log_config_exists
    assert @resp.exists?
  end

  def test_arn
    assert_equal(@resp.arn, 'test1')
  end

  def test_name
    assert_equal(@resp.name, 'test1')
  end

  def test_sampling_rate
    assert_equal(@resp.sampling_rate, 1)
  end

  def test_end_points
    assert_equal(@resp.end_points, [])
  end

  def test_fields
    assert_equal(@resp.fields, [])
  end
end
require 'helper'
require 'aws_cloudfront_realtime_log_configs'
require 'aws-sdk-core'

class AwsCloudFrontRealtimeLogConfigsConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsCloudFrontRealtimeLogConfigs.new(client_args: { stub_responses: true })
  end

  def test_rejects_other_args
    assert_raises(ArgumentError) { AwsCloudFrontRealtimeLogConfigs.new('rubbish') }
  end

  def test_realtime_log_configs_non_existing_for_empty_response
    refute AwsCloudFrontRealtimeLogConfigs.new(client_args: { stub_responses: true }).exist?
  end
end

class AwsCloudFrontRealtimeLogConfigsHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :list_realtime_log_configs
    mock_data = {}
    mock_data[:max_items] = 1
    mock_data[:is_truncated] = true
    mock_data[:marker] = 'test1'
    mock_data[:items] = []
    data[:data] = { realtime_log_configs: mock_data }
    data[:client] = Aws::CloudFront::Client
    @resp = AwsCloudFrontRealtimeLogConfigs.new(client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_realtime_log_configs_exists
    assert @resp.exists?
  end
end
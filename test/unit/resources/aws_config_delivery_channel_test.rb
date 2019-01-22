require 'helper'
require 'aws_config_delivery_channel'
require 'aws-sdk-core'

class AwsConfigDeliveryChannelConstructorTest < Minitest::Test

  def test_empty_params_ok
    AwsConfigDeliveryChannel.new(client_args: { stub_responses: true })
  end

  def test_accepts_config_delivery_channel_name
    AwsConfigDeliveryChannel.new(channel_name: 'config_delivery_channel', client_args: { stub_responses: true })
  end

  def test_rejects_unrecognized_params
    assert_raises(ArgumentError) { AwsConfigDeliveryChannel.new(rubbish: 9) }
  end

  def test_config_delivery_channel_non_existing
    refute AwsConfigDeliveryChannel.new(channel_name: 'config_delivery_channel-1234abcd', client_args: { stub_responses: true }).exists?
  end
end

class AwsConfigDeliveryChannelHappyPathTest < Minitest::Test

  def setup
    data = {}
    data[:method] = :describe_delivery_channels
    mock_config_delivery_channel = {}
    mock_config_delivery_channel[:name] = 'channel'
    mock_config_delivery_channel[:s3_bucket_name] = 'bucket'
    mock_config_delivery_channel[:s3_key_prefix] = 'prefix'
    mock_config_delivery_channel[:sns_topic_arn] = 'arn:aws:sns:::my-topic-name'
    mock_config_delivery_channel[:config_snapshot_delivery_properties] = { delivery_frequency: 'Three_Hours' }
    data[:data] = { :delivery_channels => [mock_config_delivery_channel] }
    data[:client] = Aws::ConfigService::Client
    @config_delivery_channel = AwsConfigDeliveryChannel.new(channel_name: 'channel', client_args: { stub_responses: true }, stub_data: [data])
  end

  def test_config_delivery_channel_exists
    assert @config_delivery_channel.exists?
  end

  def test_config_delivery_channel_name
    assert_equal(@config_delivery_channel.channel_name, 'channel')
  end

  def test_config_delivery_channel_bucket
    assert_equal(@config_delivery_channel.s3_bucket_name, 'bucket')
  end

  def test_config_delivery_channel_topic
    assert_equal(@config_delivery_channel.sns_topic_arn, 'arn:aws:sns:::my-topic-name')
  end

  def test_config_delivery_channel_delivery_frequency
    assert_equal(@config_delivery_channel.delivery_frequency_in_hours, 3)
  end
end


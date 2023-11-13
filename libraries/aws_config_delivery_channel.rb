require 'aws_backend'

class AwsConfigDeliveryChannel < AwsResourceBase
  name 'aws_config_delivery_channel'
  desc 'Verifies settings for AWS Config Delivery Channel.'
  example <<-EXAMPLE
    describe aws_config_delivery_channel do
      it { should exist }
      its('s3_bucket_name') { should eq 'S#_BUCKET_NAME' }
      its('sns_topic_arn') { should eq arn:aws:sns:us-east-1:721741954427:sns_topic' }
    end
  EXAMPLE

  attr_reader :channel_name, :s3_bucket_name, :s3_key_prefix, :sns_topic_arn, :delivery_frequency_in_hours

  def initialize(opts = {})
    opts = { channel_name: opts } if opts.is_a?(String)

    super(opts)
    validate_parameters(allow: [:channel_name])

    query = !opts.nil? && opts.key?(:channel_name) ? { delivery_channel_names: [opts[:channel_name]] } : {}

    catch_aws_errors do
      begin
        resp = @aws.config_client.describe_delivery_channels(query)
      rescue Aws::ConfigService::Errors::NoSuchDeliveryChannelException
        return
      end
      channel = resp.delivery_channels.first.to_h
      @channel_name   = channel[:name]
      @s3_bucket_name = channel[:s3_bucket_name]
      @s3_key_prefix  = channel[:s3_key_prefix]
      @sns_topic_arn  = channel[:sns_topic_arn]
      @delivery_frequency_in_hours = channel.dig(:config_snapshot_delivery_properties, :delivery_frequency)
      frequencies = {
        'One_Hour' => 1,
        'TwentyFour_Hours' => 24,
        'Three_Hours' => 3,
        'Six_Hours' => 6,
        'Twelve_Hours' => 12,
      }
      @delivery_frequency_in_hours = frequencies[@delivery_frequency_in_hours]
    end
  end

  def resource_id
    "#{@sns_topic_arn}_#{@channel_name}"
  end

  def exists?
    !@s3_bucket_name.nil?
  end

  def to_s
    "Config Delivery Channel #{@channel_name}"
  end
end

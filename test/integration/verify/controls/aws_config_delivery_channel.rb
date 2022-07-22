title 'Test single AWS Config Delivery Channel'

aws_delivery_channel_name = input(:aws_delivery_channel_name, value: '', description: 'The AWS Config Delivery Channel name.')
aws_delivery_channel_bucket_name = input(:aws_delivery_channel_bucket_name, value: '', description: 'The AWS Config Delivery Channel bucket name.')
aws_delivery_channel_sns_topic_arn = input(:aws_delivery_channel_sns_topic_arn, value: '', description: 'The AWS Config Delivery Channel topic name.')
aws_create_configuration_recorder = input(:aws_create_configuration_recorder, value: 0, description:'Flag to enable configuration recorder controls since there can only be one per region of these.')

control 'aws-config-delivery-channel-1.0' do
  only_if { aws_create_configuration_recorder.to_i == 1 }
  impact 1.0
  title 'Ensure AWS Config Delivery Channel has the correct properties.'

  describe aws_config_delivery_channel do
    it { should exist }
    its('channel_name') { should eq aws_delivery_channel_name }
    its('s3_bucket_name') { should eq aws_delivery_channel_bucket_name }
    its('s3_key_prefix') { should eq nil }
    its('sns_topic_arn') { should eq aws_delivery_channel_sns_topic_arn }
    its('delivery_frequency_in_hours') { should eq 24 }
  end

  describe aws_config_delivery_channel(channel_name: aws_delivery_channel_name) do
    it { should exist }
    its('channel_name') { should eq aws_delivery_channel_name }
    its('s3_bucket_name') { should eq aws_delivery_channel_bucket_name }
    its('s3_key_prefix') { should eq nil }
    its('sns_topic_arn') { should eq aws_delivery_channel_sns_topic_arn }
    its('delivery_frequency_in_hours') { should eq 24 }
  end

  describe aws_config_delivery_channel(channel_name: 'notthere') do
    it { should_not exist }
  end
end
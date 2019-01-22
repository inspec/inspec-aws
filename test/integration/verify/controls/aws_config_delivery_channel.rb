title 'Test single AWS Config Delivery Channel'

aws_delivery_channel_name = attribute(:aws_delivery_channel_name, default: '', description: 'The AWS Config Delivery Channel name.')
aws_delivery_channel_bucket_name = attribute(:aws_delivery_channel_bucket_name, default: '', description: 'The AWS Config Delivery Channel bucket name.')
aws_delivery_channel_sns_topic_arn = attribute(:aws_delivery_channel_sns_topic_arn, default: '', description: 'The AWS Config Delivery Channel topic name.')

control 'aws-vpc-1.0' do

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
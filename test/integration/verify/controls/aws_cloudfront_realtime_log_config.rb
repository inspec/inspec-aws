aws_cloudfront_realtime_log_config_name = input(:aws_cloudfront_realtime_log_config_name, value: '', description: '')
aws_cloudfront_realtime_log_config_arn = input(:aws_cloudfront_realtime_log_config_arn, value: '', description: '')
aws_cloudfront_realtime_log_config_sampling_rate = input(:aws_cloudfront_realtime_log_config_sampling_rate, value: '', description: '')

control 'aws-cloudfront-realtime-log-config-1.0' do
  title 'Gets a real-time log configuration.'

  describe aws_cloudfront_realtime_log_config(name: aws_cloudfront_realtime_log_config_name) do
    it { should exist }
  end

  describe aws_cloudfront_realtime_log_config(name: aws_cloudfront_realtime_log_config_name) do
    its('arn') { should eq aws_cloudfront_realtime_log_config_arn }
    its('name') { should eq aws_cloudfront_realtime_log_config_name }
    its('sampling_rate') { should eq aws_cloudfront_realtime_log_config_sampling_rate }
    its('end_points') { should_not be_empty }
    its('end_points_stream_types') { should include 'Kinesis' }
    its('end_points_kinesis_stream_config_role_arns') { should_not include 'arn:aws:iam::1234567890:role/cloudfront-realtime-log-config-example' }
    its('end_points_kinesis_stream_config_stream_arns') { should_not include 'arn:aws:kinesis:us-east-2:1234567890:stream/terraform-kinesis-test' }
    its('fields') { should include 'timestamp' }
  end
end

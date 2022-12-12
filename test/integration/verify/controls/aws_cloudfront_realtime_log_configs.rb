aws_cloudfront_realtime_log_config_name = input(:aws_cloudfront_realtime_log_config_name, value: '', description: '')
aws_cloudfront_realtime_log_config_arn = input(:aws_cloudfront_realtime_log_config_arn, value: '', description: '')
aws_cloudfront_realtime_log_config_sampling_rate = input(:aws_cloudfront_realtime_log_config_sampling_rate, value: '', description: '')

control 'aws-cloudfront-realtime-log-configs-1.0' do
  title 'Gets a list of real-time log configurations.'

  describe aws_cloudfront_realtime_log_configs do
    it { should exist }
  end

  describe aws_cloudfront_realtime_log_configs do
    its('arns') { should include aws_cloudfront_realtime_log_config_arn }
    its('names') { should include aws_cloudfront_realtime_log_config_name }
    its('sampling_rates') { should include aws_cloudfront_realtime_log_config_sampling_rate }
    its('end_points') { should_not be_empty }
    its('fields') { should_not be_empty }
  end
end

aws_cloudwatch_log_stream_name = input(:aws_cloudwatch_log_stream_name, value: '', description: '')
aws_cloudwatch_log_group_name = input(:aws_cloudwatch_log_group_name, value: '', description: '')
aws_cloudwatch_log_stream_arn = input(:aws_cloudwatch_log_stream_arn, value: '', description: '')

control 'aws-cloudwatch-logs-log-stream-1.0' do
  impact 1.0
  title 'Describes the AWS cloudwatch logs log-stream.'
  
  describe aws_cloudwatchlogs_log_stream(log_stream_name_prefix: aws_cloudwatch_log_stream_name, log_group_name: aws_cloudwatch_log_group_name) do
    it { should exist }
    its('log_stream_name') { should eq aws_cloudwatch_log_stream_name }
    its('arn') { should eq aws_cloudwatch_log_stream_arn }
    its('last_event_timestamp') { should eq nil }
    its('stored_bytes') { should eq 0 }
    its('upload_sequence_token') { should eq nil }
  end
end

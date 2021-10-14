# frozen_string_literal: true
aws_cloudwatch_log_stream_name = attribute('aws_cloudwatch_log_stream_name', value: '', description: '')
aws_cloudwatch_log_group_name = attribute('aws_cloudwatch_log_group_name', value: '', description: '')
aws_cloudwatch_log_stream_arn = attribute('aws_cloudwatch_log_stream_arn', value: '', description: '')

control 'aws_cloudwatch_logs_log_stream-1.0' do
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

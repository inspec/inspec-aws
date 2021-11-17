# frozen_string_literal: true
aws_cloudwatch_log_stream_name = attribute('aws_cloudwatch_log_stream_name', value: '', description: '')
aws_cloudwatch_log_group_name = attribute('aws_cloudwatch_log_group_name', value: '', description: '')
aws_cloudwatch_log_stream_arn = attribute('aws_cloudwatch_log_stream_arn', value: '', description: '')

control 'aws_cloudwatch_logs_log_streams-1.0' do
  impact 1.0
  title 'Describes the AWS cloudwatch logs log-streams.'
  describe aws_cloudwatchlogs_log_streams(log_group_name: aws_cloudwatch_log_group_name) do
    it { should exist }
    its('log_stream_names') { should include aws_cloudwatch_log_stream_name }
    its('arns') { should include aws_cloudwatch_log_stream_arn }
    its('last_event_timestamps') { should include nil }
    its('stored_bytes') { should include 0 }
    its('upload_sequence_tokens') { should include nil }
  end
end
title 'Test single AWS Cloudwatch Log Metric Filter'

aws_cloud_watch_log_metric_filter_name = input(:aws_cloud_watch_log_metric_filter_name, value: '', description: 'The AWS Cloudwatch Log Metric Filter name.')
aws_cloud_watch_log_metric_filter_two_name = input(:aws_cloud_watch_log_metric_filter_two_name, value: '', description: 'The AWS Cloudwatch Log Metric Filter name.')
aws_cloud_watch_log_metric_filter_log_group_name = input(:aws_cloud_watch_log_metric_filter_log_group_name, value: '', description: 'The AWS Cloudwatch Log Metric Filter log group name.')
aws_cloud_watch_log_metric_filter_two_log_group_name = input(:aws_cloud_watch_log_metric_filter_two_log_group_name, value: '', description: 'The AWS Cloudwatch Log Metric Filter log group name.')
aws_cloud_watch_log_metric_filter_metric_name = input(:aws_cloud_watch_log_metric_filter_metric_name, value: '', description: 'The AWS Cloudwatch Log Metric Filter metric name.')
aws_cloud_watch_log_metric_filter_two_metric_name = input(:aws_cloud_watch_log_metric_filter_two_metric_name, value: '', description: 'The AWS Cloudwatch Log Metric Filter metric name.')
aws_cloud_watch_log_metric_filter_pattern = input(:aws_cloud_watch_log_metric_filter_pattern, value: '', description: 'The AWS Cloudwatch Log Metric Filter metric pattern.')
aws_cloud_watch_log_metric_filter_two_pattern = input(:aws_cloud_watch_log_metric_filter_two_pattern, value: '', description: 'The AWS Cloudwatch Log Metric Filter metric pattern.')

control 'aws-cloudwatch-log-metric-filter-1.0' do
  impact 1.0
  title 'Ensure AWS Cloudwatch Log Metric Filter has the correct properties.'

  describe aws_cloudwatch_log_metric_filter(filter_name: aws_cloud_watch_log_metric_filter_name, log_group_name: aws_cloud_watch_log_metric_filter_log_group_name) do
    it { should exist }
    its('pattern') { should cmp aws_cloud_watch_log_metric_filter_pattern }
    its('metric_name') { should cmp aws_cloud_watch_log_metric_filter_metric_name }
    its('log_group_name') { should cmp aws_cloud_watch_log_metric_filter_log_group_name }
    its('filter_name') { should cmp aws_cloud_watch_log_metric_filter_name }
  end

  describe aws_cloudwatch_log_metric_filter(filter_name: aws_cloud_watch_log_metric_filter_two_name, log_group_name: aws_cloud_watch_log_metric_filter_two_log_group_name) do
    it { should exist }
    its('pattern') { should cmp aws_cloud_watch_log_metric_filter_two_pattern }
    its('metric_name') { should cmp aws_cloud_watch_log_metric_filter_two_metric_name }
    its('log_group_name') { should cmp aws_cloud_watch_log_metric_filter_two_log_group_name }
    its('filter_name') { should cmp aws_cloud_watch_log_metric_filter_two_name }
  end

  describe aws_cloudwatch_log_metric_filter(pattern: aws_cloud_watch_log_metric_filter_pattern) do
    it { should exist }
    its('pattern') { should cmp aws_cloud_watch_log_metric_filter_pattern }
    its('metric_name') { should cmp aws_cloud_watch_log_metric_filter_metric_name }
    its('log_group_name') { should cmp aws_cloud_watch_log_metric_filter_log_group_name }
    its('filter_name') { should cmp aws_cloud_watch_log_metric_filter_name }
  end

  describe aws_cloudwatch_log_metric_filter(pattern: aws_cloud_watch_log_metric_filter_two_pattern) do
    it { should exist }
    its('pattern') { should cmp aws_cloud_watch_log_metric_filter_two_pattern }
    its('metric_name') { should cmp aws_cloud_watch_log_metric_filter_two_metric_name }
    its('log_group_name') { should cmp aws_cloud_watch_log_metric_filter_two_log_group_name }
    its('filter_name') { should cmp aws_cloud_watch_log_metric_filter_two_name }
  end

  describe aws_cloudwatch_log_metric_filter(pattern: 'notthere') do
    it { should_not exist }
  end

  describe aws_cloudwatch_log_metric_filter(filter_name: 'notthere', log_group_name: 'notthere') do
    it { should_not exist }
  end
end
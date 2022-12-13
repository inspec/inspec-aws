title 'Test single AWS CloudWatch Alarm'

aws_cloud_watch_alarm_name_with_dimensions = input(:aws_cloud_watch_alarm_name_with_dimensions, value: '', description: 'The AWS CloudWatch Alarm.')
aws_cloud_watch_alarm_metric_name_with_dimensions = input(:aws_cloud_watch_alarm_metric_name_with_dimensions, value: '', description: 'The AWS CloudWatch Alarm metric.')
aws_cloud_watch_log_metric_filter_namespace_with_dimensions = input(:aws_cloud_watch_log_metric_filter_namespace_with_dimensions, value: '', description: 'The AWS CloudWatch namespace.')
aws_cloud_watch_alarm_name = input(:aws_cloud_watch_alarm_name, value: '', description: 'The AWS CloudWatch Alarm.')
aws_cloud_watch_alarm_metric_name = input(:aws_cloud_watch_alarm_metric_name, value: '', description: 'The AWS CloudWatch Alarm metric.')
aws_cloud_watch_log_metric_filter_namespace = input(:aws_cloud_watch_log_metric_filter_namespace, value: '', description: 'The AWS CloudWatch namespace.')

control 'aws-cloudwatch-alarm-1.0' do
  title 'Ensure AWS CloudWatch Alarm has the correct properties.'

  describe aws_cloudwatch_alarm(metric_name: aws_cloud_watch_alarm_metric_name, metric_namespace: aws_cloud_watch_log_metric_filter_namespace) do
    it { should exist }
    its('alarm_name') { should eq aws_cloud_watch_alarm_name }
  end

  describe aws_cloudwatch_alarm(metric_name: aws_cloud_watch_alarm_metric_name_with_dimensions, metric_namespace: aws_cloud_watch_log_metric_filter_namespace_with_dimensions, dimensions: [{aws_dimension_name1: 'aws_dimension_value1'}, {aws_dimension_name2: 'aws_dimension_value2'}]) do
    it { should exist }
    its('alarm_name') { should eq aws_cloud_watch_alarm_name_with_dimensions }
  end

  describe aws_cloudwatch_alarm(metric_name: 'NotThere', metric_namespace: 'NotThere') do
    it { should_not exist }
  end
end

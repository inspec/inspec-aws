aws_cloudwatch_anomaly_detector_namespace = input(:aws_cloudwatch_anomaly_detector_namespace, value: '', description: '')
aws_cloudwatch_anomaly_detector_metric_name = input(:aws_cloudwatch_anomaly_detector_metric_name, value: '', description: '')

control 'aws-cloudwatch-anomaly-detector-1.0' do
  impact 1.0
  title 'Get the information about a anomaly detector.'

  describe aws_cloudwatch_anomaly_detector(metric_name: aws_cloudwatch_anomaly_detector_metric_name) do
    it { should exist }
  end

  describe aws_cloudwatch_anomaly_detector(metric_name: aws_cloudwatch_anomaly_detector_metric_name) do
    its('namespace') { should eq aws_cloudwatch_anomaly_detector_namespace }
    its('metric_name') { should eq aws_cloudwatch_anomaly_detector_metric_name }
    its('dimensions') { should_not be_empty }
    its('dimensions_names') { should include 'InstanceId' }
    its('dimensions_values') { should_not include 'i-1234567890' }
    its('stat') { should eq 'Average' }
    its('configuration.excluded_time_ranges') { should be_empty }
    its('configuration.metric_timezone') { should be_empty }
    its('state_value') { should eq 'TRAINED' }
  end
end
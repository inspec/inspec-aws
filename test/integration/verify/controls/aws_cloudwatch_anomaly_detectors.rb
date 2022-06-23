aws_cloudwatch_anomaly_detector_namespace = input(:aws_cloudwatch_anomaly_detector_namespace, value: '', description: '')
aws_cloudwatch_anomaly_detector_metric_name = input(:aws_cloudwatch_anomaly_detector_metric_name, value: '', description: '')

control 'aws-cloudwatch-anomaly-detectors-1.0' do
  impact 1.0
  title 'List Anomaly Detector.'

  describe aws_cloudwatch_anomaly_detectors do
    it { should exist }
  end

  describe aws_cloudwatch_anomaly_detectors do
    its('namespaces') { should include aws_cloudwatch_anomaly_detector_namespace }
    its('metric_names') { should include aws_cloudwatch_anomaly_detector_metric_name }
    its('dimensions') { should_not be_empty }
    its('stats') { should include 'Average' }
    its('configurations') { should_not be_empty }
    its('state_values') { should include 'TRAINED' }
  end
end
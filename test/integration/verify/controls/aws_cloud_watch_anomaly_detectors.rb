control 'aws-cloud-watch-anomaly-detectors-1.0' do
  impact 1.0
  title 'List Anomaly Detector.'

  describe aws_cloud_watch_anomaly_detectors do
    it { should exist }
  end

  describe aws_cloud_watch_anomaly_detectors do
    its('namespaces') { should include 'AWS/EC2' }
    its('metric_names') { should include 'CPUUtilization' }
    its('dimensions') { should_not be_empty }
    its('stats') { should include 'Average' }
    its('configurations') { should_not be_empty }
    its('state_values') { should include 'TRAINED' }
  end
end
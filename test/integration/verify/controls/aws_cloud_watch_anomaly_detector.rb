control 'aws-cloud-watch-anomaly-detector-1.0' do
  impact 1.0
  title 'Get the information about a anomaly detector.'

  describe aws_cloud_watch_anomaly_detector(metric_name: 'CPUUtilization') do
    it { should exist }
  end

  describe aws_cloud_watch_anomaly_detector(metric_name: 'CPUUtilization') do
    its('namespace') { should eq 'AWS/EC2' }
    its('metric_name') { should eq 'CPUUtilization' }
    its('dimensions') { should_not be_empty }
    its('dimensions_names') { should include 'InstanceId' }
    its('dimensions_values') { should include 'i-0111913dd854e6590' }
    its('stat') { should eq 'Average' }
    its('configuration.excluded_time_ranges') { should be_empty }
    its('configuration.metric_timezone') { should be_empty }
    its('state_value') { should eq 'TRAINED' }
  end
end
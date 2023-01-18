control 'aws-logs-metric-filters-1.0' do
  title 'Describes the metric filters of the logs.'

  describe aws_logs_metric_filters do
    it { should exist }
  end

  describe aws_logs_metric_filters do
    its('filter_names') { should include 'TestMetricFilter' }
    its('filter_patterns') { should include 'ERROR' }
    its('metric_transformations') { should_not be_empty }
    its('creation_times') { should_not be_empty }
  end
end

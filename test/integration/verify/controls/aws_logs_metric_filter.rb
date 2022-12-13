control 'aws-logs-metric-filter-1.0' do
  title 'Describes the metric filter of the logs.'

  describe aws_logs_metric_filter(filter_name: 'TestMetricFilter') do
    it { should exist }
  end

  describe aws_logs_metric_filter(filter_name: 'TestMetricFilter') do
    its('filter_name') { should eq 'TestMetricFilter' }
    its('filter_pattern') { should eq 'ERROR' }
    its('metric_transformations.first.metric_name') { should eq 'TestMetric' }
    its('metric_transformations.first.metric_namespace') { should eq 'TestNamespace' }
    its('metric_transformations.first.metric_value') { should eq '1' }
  end
end

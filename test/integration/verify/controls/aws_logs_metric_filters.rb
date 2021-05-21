describe aws_logs_metric_filters do
    it { should exist }
  end
  
  describe aws_logs_metric_filters do
    its('filter_names') { should include 'test1' }
    its('filter_patterns') { should include 'ERROR' }
    its('metric_transformations') { should_not be_empty }
    its('creation_times') { should include 1621452000626 }
  end
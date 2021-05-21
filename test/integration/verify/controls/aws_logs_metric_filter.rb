describe aws_logs_metric_filter(filter_name: 'test1') do
    it { should exist }
  end
  
  describe aws_logs_metric_filter(filter_name: 'test1') do
    its('filter_name') { should eq 'test1' }
    its('filter_pattern') { should eq 'ERROR' }
    its('metric_transformations.first.metric_name') { should eq 'test1' }
    its('metric_transformations.first.metric_namespace') { should eq 'test' }
    its('metric_transformations.first.metric_value') { should eq '1' }
    its('metric_transformations.first.default_value') { should eq 1.0 }
    its('creation_time') { should eq 1621452000626 }
  end
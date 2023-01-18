aws_traffic_filter_id = input(:aws_traffic_filter_id, value: '', description: 'aws traffic filter id.')
aws_traffic_filter_desc = input(:aws_traffic_filter_desc, value: '', description: 'description aws traffic filter .')

title 'Test AWS Traffic Filters in bulk'

control 'aws-traffic-filters-1.0' do
  title 'Ensure AWS Traffic Filters resource has the correct properties.'

  describe aws_ec2_traffic_filters do
    it { should exist }
  end

  describe aws_ec2_traffic_filters do
    its('aws_ec2_traffic_filter_ids') { should include aws_traffic_filter_id }
    its('descriptions') { should include aws_traffic_filter_desc  }
  end
end

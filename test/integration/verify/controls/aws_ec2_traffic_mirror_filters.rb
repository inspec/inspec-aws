aws_traffic_filter_id = attribute(:aws_traffic_filter_id, value: '', description: 'aws traffic filter id.')
aws_traffic_filter_desc = attribute(:aws_traffic_filter_desc, value: '', description: ' description aws traffic filter .')


title 'Test AWS Traffic Filter in bulk'
control 'aws_traffic_filter-1.0' do

  impact 1.0
  title 'Ensure AWS Traffic Filter resource has the correct properties.'

  describe aws_ec2_traffic_filter do
    it { should exist }
  end

  describe aws_ec2_traffic_filter do
    its('aws_ec2_traffic_filter_ids') { should include aws_traffic_filter_id }
    its('descriptions') { should include aws_traffic_filter_desc  }
  end
end

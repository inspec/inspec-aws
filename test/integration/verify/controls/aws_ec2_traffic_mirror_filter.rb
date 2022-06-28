aws_traffic_filter_id = input(:aws_traffic_filter_id, value: '', description: 'aws traffic filter id.')
aws_traffic_filter_desc = input(:aws_traffic_filter_desc, value: '', description: 'description aws traffic filter .')

title 'Test single AWS Traffic Filter'

control 'aws-traffic-filter-1.0' do
  impact 1.0
  title 'Ensure AWS Traffic Filter resource has the correct properties.'

  describe aws_ec2_traffic_mirror_filter(aws_ec2_traffic_mirror_filter_id: aws_traffic_filter_id ) do
    it { should exist }
  end

  describe aws_ec2_traffic_mirror_filter(aws_ec2_traffic_mirror_filter_id: aws_traffic_filter_id ) do
    its('aws_ec2_traffic_filter_id') { should eq aws_traffic_filter_id }
    its('description') { should eq aws_traffic_filter_desc  }
  end
end



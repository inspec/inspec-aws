title 'Test AWS Route Tables in bulk'

aws_vpc_id = input(:aws_vpc_id, value: '', description: 'The AWS VPC ID.')
aws_route_table_first_id = input(:aws_route_table_first_id, value: '', description: 'The AWS route table ID.')
aws_route_table_second_id = input(:aws_route_table_second_id, value: '', description: 'The AWS route table ID.')

control 'aws-route-tables-1.0' do

  impact 1.0
  title 'Ensure AWS Route Tables plural resource has the correct properties.'

  describe aws_route_tables do
    it { should exist }
    its('count') { should be >= 2 }
    its('vpc_ids') { should include aws_vpc_id }
    its('route_table_ids') { should include aws_route_table_first_id }
    its('route_table_ids') { should include aws_route_table_second_id }
  end

end
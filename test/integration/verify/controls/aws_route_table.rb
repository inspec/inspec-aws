title 'Test single AWS Route Table'

aws_vpc_id = input(:aws_vpc_id, value: '', description: 'The AWS VPC ID.')
aws_route_table_first_id = input(:aws_route_table_first_id, value: '', description: 'The AWS route table ID.')
aws_route_table_second_id = input(:aws_route_table_second_id, value: '', description: 'The AWS route table ID.')

control 'aws-route-table-1.0' do

  impact 1.0
  title 'Ensure AWS AWS Route Table has the correct properties.'

  describe aws_route_table(route_table_id: aws_route_table_first_id) do
    it { should exist }
    its ('vpc_id') { should eq aws_vpc_id }
  end

  describe aws_route_table(aws_route_table_first_id) do
    it { should exist }
    its ('vpc_id') { should eq aws_vpc_id }
  end

  describe aws_route_table(aws_route_table_second_id) do
    it { should exist }
    its ('vpc_id') { should eq aws_vpc_id }
  end

  describe aws_route_table('rtb-1234abcd') do
    it { should_not exist }
  end

end
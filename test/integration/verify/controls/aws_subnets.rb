title 'Test AWS VPC Subnets in bulk'

aws_subnet_id = attribute(:aws_subnet_id, default: '', description: 'The AWS VPC Subnet ID.')
aws_subnet_cidr_block = attribute(:aws_subnet_cidr_block, default: '', description: 'The AWS VPC Subnet CIDR block.')
aws_vpc_id = attribute(:aws_vpc_id, default: '', description: 'The AWS VPC ID.')

control 'aws-subnets-1.0' do

  impact 1.0
  title 'Ensure AWS VPC Subnets plural resource has the correct properties.'

  describe aws_subnets do
    it                  { should exist }
    its('count')        { should be <= 100 }
    its('cidr_blocks')  { should include aws_subnet_cidr_block }
    its('vpc_ids')      { should include aws_vpc_id }
    its('subnet_ids')   { should include aws_subnet_id }
    its('states')       { should include 'available' }
  end

end
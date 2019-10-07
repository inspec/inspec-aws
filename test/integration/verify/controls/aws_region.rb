title 'Test single AWS region'

aws_region_exists = attribute(:aws_region_exists, default: 'eu-west-2', description: 'An AWS region.')
aws_region_endpoint_exists = attribute(:aws_region_endpoint_exists, default: 'ec2.eu-west-2.amazonaws.com', description: 'An AWS region.')

control 'aws-region-1.0' do

  impact 1.0
  title 'Ensure AWS region has the correct properties.'

  describe aws_region(region_name: aws_region_exists) do
    it { should exist }
    its('region_name') { should eq aws_region_exists }
    its('endpoint') { should eq aws_region_endpoint_exists }
  end

  describe aws_region(aws_region_exists) do
    it { should exist }
    its('region_name') { should eq aws_region_exists }
    its('endpoint') { should eq aws_region_endpoint_exists }
  end

  describe aws_region('not-a-real-region-1') do
    it { should_not exist }
  end

end
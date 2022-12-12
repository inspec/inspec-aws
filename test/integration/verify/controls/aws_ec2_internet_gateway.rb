aws_internet_gateway_id = input(:aws_internet_gateway_id, value: '', description: '')
aws_internet_gateway_owner_id = input(:aws_internet_gateway_owner_id, value: '', description: '')
aws_internet_gateway_vpc_id = input(:aws_internet_gateway_vpc_id, value: '', description: '')

control 'aws-ec2-internet-gateway-1.0' do

  title 'Test a singular resource of the internet gateway.'

  describe aws_ec2_internet_gateway(internet_gateway_id: aws_internet_gateway_id) do
    it { should exist }
  end

  describe aws_ec2_internet_gateway(internet_gateway_id: aws_internet_gateway_id) do
    its('attachments') { should_not be_empty }
    its('attachments_states') { should include 'available' }
    its('attachments_vpc_ids') { should include aws_internet_gateway_vpc_id }
  end

  describe aws_ec2_internet_gateway(internet_gateway_id: aws_internet_gateway_id) do
    its('internet_gateway_id') { should eq aws_internet_gateway_id }
    its('owner_id') { should eq aws_internet_gateway_owner_id }
    its('tags') { should_not be_empty }
  end

  describe aws_ec2_internet_gateway(internet_gateway_id: 'dummy') do
    it { should_not exist }
  end
end

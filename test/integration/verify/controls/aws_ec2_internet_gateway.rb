control 'aws-ec2-internet-gateway-1.0' do
  impact 1.0
  title 'Test a singular resource of the internet gateway.'

  describe aws_ec2_internet_gateway(internet_gateway_id: 'igw-02e1384257f648d3a') do
    it { should exist }
  end

  describe aws_ec2_internet_gateway(internet_gateway_id: 'igw-02e1384257f648d3a') do
    its('attachments') { should_not be_empty }
    its('attachments_states') { should include "available" }
    its('attachments_vpc_ids') { should include "vpc-00f84d6a52e079260" }
  end

  describe aws_ec2_internet_gateway(internet_gateway_id: 'igw-02e1384257f648d3a') do
    its('internet_gateway_id') { should eq 'igw-02e1384257f648d3a' }
    its('owner_id') { should eq '112758395563' }
    its('tags') { should_not be_empty }
  end
end
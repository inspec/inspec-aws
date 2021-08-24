control 'aws-ec2-internet-gateways-1.0' do
  impact 1.0
  title 'Test a plural resource of the internet gateway.'

  describe aws_ec2_internet_gateways do
    it { should exist }
  end

  describe aws_ec2_internet_gateways do
    its('attachments') { should_not be_empty }
    its('attachments_states') { should include "available" }
    its('attachments_vpc_ids') { should include ["vpc-00f84d6a52e079260"] }
  end

  describe aws_ec2_internet_gateways do
    its('internet_gateway_ids') { should include "igw-02e1384257f648d3a" }
    its('owner_ids') { should include "112758395563" }
    its('tags') { should_not be_empty }
  end
end
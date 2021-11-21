aws_internet_gateway_id = attribute("aws_internet_gateway_id", value: "", description: "")
aws_internet_gateway_owner_id = attribute("aws_internet_gateway_owner_id", value: "", description: "")
aws_internet_gateway_vpc_id = attribute("aws_internet_gateway_vpc_id", value: "", description: "")

control 'aws-ec2-internet-gateways-1.0' do

  impact 1.0
  title 'Test a plural resource of the internet gateway.'

  describe aws_ec2_internet_gateways do
    it { should exist }
  end

  describe aws_ec2_internet_gateways do
    its('attachments') { should_not be_empty }
    its('attachments_states') { should include "available" }
    its('attachments_vpc_ids') { should include [aws_internet_gateway_vpc_id] }
  end

  describe aws_ec2_internet_gateways do
    its('internet_gateway_ids') { should include aws_internet_gateway_id }
    its('owner_ids') { should include aws_internet_gateway_owner_id }
    its('tags') { should_not be_empty }
  end
end
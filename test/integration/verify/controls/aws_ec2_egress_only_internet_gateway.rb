aws_egress_only_internet_gateway_id = input(:aws_egress_only_internet_gateway_id, value: '', description: '')
aws_vpc_eoig_test1_id = input(:aws_vpc_eoig_test1_id, value: '', description: '')

control 'aws-ec2-egress-only-internet-gateway-1.0' do
  impact 1.0
  title 'Describes one or more of your egress-only internet gateways.'

  describe aws_ec2_egress_only_internet_gateway(egress_only_internet_gateway_id: aws_egress_only_internet_gateway_id) do
    it { should exist }
  end

  describe aws_ec2_egress_only_internet_gateway(egress_only_internet_gateway_id: aws_egress_only_internet_gateway_id) do
    its('attachments') { should_not be_empty }
    its('attachments_states') { should include 'attached' }
    its('attachments_vpc_ids') { should include aws_vpc_eoig_test1_id }
    its('egress_only_internet_gateway_id') { should eq aws_egress_only_internet_gateway_id }
    its('tags') { should_not be_empty }
  end
end
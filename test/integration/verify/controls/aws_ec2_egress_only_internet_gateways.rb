aws_egress_only_internet_gateway_id = input(:aws_egress_only_internet_gateway_id, value: '', description: '')

control 'aws-ec2-egress-only-internet-gateways-1.0' do
  impact 1.0
  title 'Describes one or more of your egress-only internet gateways.'

  describe aws_ec2_egress_only_internet_gateways do
    it { should exist }
  end

  describe aws_ec2_egress_only_internet_gateways do
    its('attachments') { should_not be_empty }
    its('egress_only_internet_gateway_ids') { should include aws_egress_only_internet_gateway_id }
    its('tags') { should_not be_empty }
  end
end
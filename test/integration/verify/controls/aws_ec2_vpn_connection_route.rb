aws_vpn_connection_id = attribute("aws_vpn_connection_id", value: "", description: "")

control 'aws-ec2_vpn-connection-route-1.0' do
  impact 1.0
  title 'Test the properties of the aws ec2 VPN connection route.'

  describe aws_ec2_vpn_connection_route(vpn_connection_id: aws_vpn_connection_id) do
    it { should exist }
  end

  describe aws_ec2_vpn_connection_route(vpn_connection_id: aws_vpn_connection_id) do
    its('destination_cidr_block') { should eq '192.168.10.0/24' }
    its('source') { should be_empty }
    its('state') { should eq 'available' }
  end
end
title 'Test  a AWS Network Interface permission'

skip_control 'aws-ec2-network-interface-permission-1.0' do
  impact 1.0
  title 'Ensure AWS Network Interface permission has the correct properties.'

  describe aws_ec2_network_interface_permission(network_interface_permission_id: 'NetworkInterfacePermissionId') do
    it { should exist }
    its('network_interface_id') { should eq 'test-val' }
    its('aws_account_id') { should eq 'test-val'  }
  end
end

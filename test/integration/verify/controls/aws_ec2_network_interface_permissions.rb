title 'Test  a AWS Network Interface permissions'

skip_control 'aws-ec2-network-interface-permissions-1.0' do
  impact 1.0
  title 'Ensure all the AWS Network Interface permissions has the correct properties.'

  describe aws_ec2_network_interface_permissions do
    it { should exist }
    its('network_interface_ids') { should include 'test-val' }
    its('aws_account_ids') { should include 'test-val'  }
  end
end
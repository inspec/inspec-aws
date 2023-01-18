control 'aws-ec2-network-interface-attachments-1.0' do
  title 'Test a plural resource of the aws ec2 network interface attachments.'

  describe aws_ec2_network_interface_attachments do
    it { should exist }
  end

  describe aws_ec2_network_interface_attachments do
    its('attach_times') { should_not be_empty }
    its('attachment_ids') { should_not be_empty }
    its('delete_on_terminations') { should include false }
    its('device_indexes') { should include 1 }
    its('network_card_indexes') { should_not be_empty }
    its('instance_ids') { should_not be_empty }
    its('instance_owner_ids') { should include 'amazon-aws' }
    its('statuses') { should include 'attached' }
  end
end

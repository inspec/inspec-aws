aws_network_interface_id = input(:aws_network_interface_id, value: '', description: '')

control 'aws-ec2-network-interface-attachment-1.0' do
  title 'Test a singular resource of the aws ec2 network interface attachments.'

  describe aws_ec2_network_interface_attachment(network_interface_id: aws_network_interface_id) do
    it { should exist }
  end

  describe aws_ec2_network_interface_attachment(network_interface_id: aws_network_interface_id) do
    its('attach_time') { should be_empty }
    its('attachment_id') { should_not be_empty }
    its('delete_on_termination') { should eq false }
    its('device_index') { should eq 0 }
    its('network_card_index') { should be_empty }
    its('instance_id') { should be_empty }
    its('instance_owner_id') { should eq 'amazon-aws' }
    its('status') { should eq 'attached' }
  end
end

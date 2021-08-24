control 'aws-ec2-network-interface-attachment-1.0' do
  impact 1.0
  title 'Test a singular resource of the aws ec2 network interface attachments.'

  describe aws_ec2_network_interface_attachment(network_interface_id: 'eni-08e0621ce9bc8dc56') do
    it { should exist }
  end

  describe aws_ec2_network_interface_attachment(network_interface_id: 'eni-08e0621ce9bc8dc56') do
    its('attach_time') { should be_empty }
    its('attachment_id') { should eq "ela-attach-095c19182f6144c17" }
    its('delete_on_termination') { should eq false }
    its('device_index') { should eq 1 }
    its('network_card_index') { should be_empty }
    its('instance_id') { should be_empty }
    its('instance_owner_id') { should eq 'amazon-aws' }
    its('status') { should eq 'attached' }
  end
end
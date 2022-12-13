aws_volume_attachment_instance_device_name = input(:aws_volume_attachment_instance_device_name, value: '', description: '')
aws_volume_attachment_instance_volume_id = input(:aws_volume_attachment_instance_volume_id, value: '', description: '')

control 'aws-ec2-volume-attachment-1.0' do
  title 'Test the properties of the aws ec2 volume attachment.'

  describe aws_ec2_volume_attachment(volume_id: aws_volume_attachment_instance_volume_id) do
    it { should exist }
  end

  describe aws_ec2_volume_attachment(volume_id: aws_volume_attachment_instance_volume_id) do
    its('device') { should eq aws_volume_attachment_instance_device_name }
    its('instance_id') { should_not be_empty }
    its('state') { should eq 'attached' }
    its('volume_id') { should eq aws_volume_attachment_instance_volume_id }
    its('delete_on_termination') { should eq false }
  end
end

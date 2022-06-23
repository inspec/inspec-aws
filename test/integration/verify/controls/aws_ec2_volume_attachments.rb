aws_volume_attachment_instance_device_name = input(:aws_volume_attachment_instance_device_name, value: '', description: '')
aws_volume_attachment_instance_volume_id = input(:aws_volume_attachment_instance_volume_id, value: '', description: '')

control 'aws-ec2-volume-attachments-1.0' do
  impact 1.0
  title 'Test the properties of the aws ec2 volume attachments.'

  describe aws_ec2_volume_attachments do
    it { should exist }
  end

  describe aws_ec2_volume_attachments do
    its('attach_times') { should_not be_empty }
    its('devices') { should include [aws_volume_attachment_instance_device_name] }
    its('instance_ids') { should_not be_empty }
    its('states') { should include ['attached'] }
    its('volume_ids') { should include [aws_volume_attachment_instance_volume_id] }
    its('delete_on_terminations') { should include [false] }
  end
end
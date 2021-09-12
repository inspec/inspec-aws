aws_ebs_volume_id = attribute(:aws_ebs_volume_id, value: '', description: 'The AWS EBS Volume ID.')

control 'aws-ec2-volume-attachments-1.0' do
  impact 1.0
  title 'Lists Volume Attachments'

  describe aws_ec2_volume_attachments(volume_id: aws_ebs_volume_id) do
    it { should exist }
  end

  describe aws_ec2_volume_attachments(volume_id: aws_ebs_volume_id) do
    its ('attach_times') { should_not include 'dummy' }
    its ('devices') { should_not include 'dummy' }
    its ('instance_ids') { should_not include 'dummy' }
    its ('states') { should include 'attached' }
    its ('volume_ids') { should include aws_ebs_volume_id }
    its ('delete_on_terminations') { should include true }
  end

  describe aws_ec2_volume_attachments(volume_id: 'vol-1234567890') do
    it { should exist }
  end
end
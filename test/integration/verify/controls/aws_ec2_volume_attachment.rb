aws_ebs_volume_id = attribute(:aws_ebs_volume_id, value: '', description: 'The AWS EBS Volume ID.')

control 'aws-ec2-volume-attachment-1.0' do
  impact 1.0
  title 'Describes EC2 volume attachments.'

  describe aws_ec2_volume_attachment(volume_id: aws_ebs_volume_id) do
    it { should exist }
  end

  describe aws_ec2_volume_attachment(volume_id: aws_ebs_volume_id) do
    its ('attach_time') { should_not eq '2021-07-23 14:08:44.000000000 +0000' }
    its ('device') { should_not eq 'dummy' }
    its ('instance_id') { should_not eq 'dummy' }
    its ('state') { should eq 'attached' }
    its ('volume_id') { should eq aws_ebs_volume_id }
    its ('delete_on_termination') { should eq true }
  end

  describe aws_ec2_volume_attachment(volume_id: 'vol-1234567890') do
    it { should_not exist }
  end
end
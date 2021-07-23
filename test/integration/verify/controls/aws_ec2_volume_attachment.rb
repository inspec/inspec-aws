control 'aws-ec2-volume-attachment-1.0' do
  impact 1.0
  title 'Describes EC2 volume attachments.'

  describe aws_ec2_volume_attachment(volume_id: 'vol-019e2fd110123fdb9') do
    it { should exist }
  end

  describe aws_ec2_volume_attachment(volume_id: 'vol-019e2fd110123fdb9') do
    its ('attach_time') { should_not eq '2021-07-23 14:08:44.000000000 +0000' }
    its ('device') { should eq '/dev/sda1' }
    its ('instance_id') { should eq 'i-0fb633736bc5868b1' }
    its ('state') { should eq 'attached' }
    its ('volume_id') { should eq 'vol-019e2fd110123fdb9' }
    its ('delete_on_termination') { should eq true }
  end

  describe aws_ec2_volume_attachment(volume_id: 'vol-1234567890') do
    it { should_not exist }
  end
end
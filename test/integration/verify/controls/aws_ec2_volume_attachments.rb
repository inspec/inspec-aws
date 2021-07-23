control 'aws-ec2-volume-attachments-1.0' do
  impact 1.0
  title 'Lists Volume Attachments'

  describe aws_ec2_volume_attachments(volume_id: 'vol-019e2fd110123fdb9') do
    it { should exist }
  end

  describe aws_ec2_volume_attachments(volume_id: 'vol-019e2fd110123fdb9') do
    its ('attach_times') { should include '2021-07-23 14:08:44.000000000 +0000' }
    its ('devices') { should include '/dev/sda1' }
    its ('instance_ids') { should include 'i-0fb633736bc5868b1' }
    its ('states') { should include 'attached' }
    its ('volume_ids') { should include 'vol-019e2fd110123fdb9' }
    its ('delete_on_terminations') { should include true }
  end

  describe aws_ec2_volume_attachments(volume_id: 'vol-1234567890') do
    it { should exist }
  end
end
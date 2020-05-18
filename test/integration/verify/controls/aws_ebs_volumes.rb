aws_ebs_volume_id = attribute(:aws_ebs_volume_id, value: '', description: 'The AWS EBS Volume ID.')

title 'Test AWS EBS Volumes in bulk'
control 'aws-ebs-volumes-1.0' do

  impact 1.0
  title 'Ensure AWS EBS Volumes plural resource has the correct properties.'

  describe aws_ebs_volumes do
    it { should exist }
    its ('volume_ids') { should include aws_ebs_volume_id }
  end
end
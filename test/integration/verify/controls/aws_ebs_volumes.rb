aws_ebs_volume_id = input(:aws_ebs_volume_id, value: '', description: 'The AWS EBS Volume ID.')
aws_ebs_volume_encrypted = input(:aws_ebs_volume_encrypted, value: '', description: 'Whether the AWS EBS Volume is encrypted.')
aws_ebs_volume_iops = input(:aws_ebs_volume_iops, value: '', description: 'The iops settings of the volumes')
aws_ebs_volume_size = input(:aws_ebs_volume_size, value: '', description: 'The size of the ebs volume.')
aws_ebs_volume_type = input(:aws_ebs_volume_type, value: '', description: 'The type of ebs volume.')

title 'Test AWS EBS Volumes in bulk'

control 'aws-ebs-volumes-1.0' do
  title 'Ensure AWS EBS Volumes plural resource has the correct properties.'

  describe aws_ebs_volumes do
    it { should exist }
    its ('volume_ids') { should include aws_ebs_volume_id }
    its ('encrypted') { should include aws_ebs_volume_encrypted }
    its ('iops') { should include aws_ebs_volume_iops } 
    its ('sizes') { should include aws_ebs_volume_size }
    its ('volume_types') { should include aws_ebs_volume_type }
  end
end

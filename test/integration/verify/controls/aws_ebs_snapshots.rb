aws_ebs_snapshot_id = input(:aws_ebs_snapshot_id, value: '', description: 'The AWS EBS Snapshot ID.')

title 'Test AWS EBS Snapshots in bulk'

control 'aws-ebs-snapshots-1.0' do
  impact 1.0
  title 'Ensure AWS EBS Snapshots plural resource has the correct properties.'

  describe aws_ebs_snapshots do
    it { should exist }
    its('snapshot_ids') { should include aws_ebs_snapshot_id }
  end
end

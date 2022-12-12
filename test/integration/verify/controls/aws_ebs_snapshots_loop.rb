aws_ebs_snapshot_id = input(:aws_ebs_snapshot_id, value: '', description: 'The AWS EBS Snapshot ID.')
aws_ebs_snapshot_name = input(:aws_ebs_snapshot_name, value: '', description: 'The AWS EBS Snapshot name.')
aws_ebs_snapshot_owner_id = input(:aws_ebs_snapshot_owner_id, value: '', description: 'The AWS EBS Owner ID.')

title 'Test AWS EBS Snapshots in bulk using plural and singular resources'

control 'aws-ebs-snapshots-loop-1.0' do
  title 'Ensure AWS EBS Snapshots plural resource using singular resource for detail.'

  aws_ebs_snapshots.where { snapshot_id == aws_ebs_snapshot_id }.snapshot_ids.each do |snapshot|
    describe aws_ebs_snapshot(snapshot_id: snapshot) do
      it { should exist }
      its('snapshot_id') { should eq aws_ebs_snapshot_id }
      its('tags') { should include(key: 'Name', value: aws_ebs_snapshot_name) }
      its('owner_id') { should eq aws_ebs_snapshot_owner_id }
      it { should_not be_encrypted }
    end
  end
end

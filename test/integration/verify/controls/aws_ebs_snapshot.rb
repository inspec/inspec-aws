aws_ebs_snapshot_name = attribute(:aws_ebs_snapshot_name, value: '', description: 'The AWS EBS Snapshot name.')
aws_ebs_snapshot_id = attribute(:aws_ebs_snapshot_id, value: '', description: 'The AWS EBS Snapshot ID.')

title 'Test single AWS EBS Snapshot'
control 'aws-ebs-snapshot-1.0' do

  impact 1.0
  title 'Ensure AWS EBS Snapshot has the correct properties.'

  describe aws_ebs_snapshot(snapshot_id: aws_ebs_snapshot_id) do
    it { should exist }
    its ('snapshot_id') { should eq aws_ebs_snapshot_id }
    its('tags') { should include(key: 'Name', value: aws_ebs_snapshot_name) }
  end

  describe aws_ebs_snapshot(snapshot_id: aws_ebs_snapshot_id) do
    it { should exist } 
    its ('snapshot_id') { should eq aws_ebs_snapshot_id }
    its('tags') { should include(key: 'Name', value: aws_ebs_snapshot_name) }
  end

  describe aws_ebs_snapshot(name: aws_ebs_snapshot_name) do
    it { should exist }
    its ('snapshot_id') { should eq aws_ebs_snapshot_id }
    its('tags') { should include(key: 'Name', value: aws_ebs_snapshot_name) }
  end

  describe aws_ebs_snapshot(name: 'not_existing_volume_name') do
    it { should_not exist }
  end

  describe aws_ebs_snapshot(snapshot_id: aws_ebs_snapshot_id) do
    it { should_not be_encrypted }
  end

  describe aws_ebs_snapshot(snapshot_id: aws_ebs_snapshot_id) do
    it { should_not be_public }
  end

  describe aws_ebs_snapshot(snapshot_id: aws_ebs_snapshot_id) do
    it { should be_private }
  end

  # Note: There is no way to create an public ebs snapshot using terraform. Therefore skipping it.
  # Tested the above accessibility (private/public) by making the ENS snapshot public using
  # aws cli. Above validation behaved correctly.
end
aws_ebs_snapshot_id = input(:aws_ebs_snapshot_id, value: '', description: 'The AWS EBS Snapshot ID.')
aws_ebs_snapshot_name = input(:aws_ebs_snapshot_name, value: '', description: 'The AWS EBS Snapshot Name.')
aws_ebs_snapshot_owner_id = input(:aws_ebs_snapshot_owner_id, value: '', description: 'The AWS EBS Snapshot Owner ID.')
aws_ebs_encrypted_snapshot_id = input(:aws_ebs_encrypted_snapshot_id, value: '', description: 'The encrypted AWS EBS Snapshot ID.')

title 'Test single AWS EBS Snapshot'

control 'aws-ebs-snapshot-1.0' do
  impact 1.0
  title 'Ensure AWS EBS Snapshot has the correct properties.'

  describe aws_ebs_snapshot(snapshot_id: aws_ebs_snapshot_id) do
    it { should exist }
    its('snapshot_id') { should eq aws_ebs_snapshot_id }
    its('owner_id') { should eq aws_ebs_snapshot_owner_id }
    its('volume_size') { should eq 1 }
    its('encrypted') { should eq false }
    its('tags') { should include(key: 'Name', value: aws_ebs_snapshot_name) }
    it { should_not be_encrypted }
    it { should_not be_public }
    its('group') { should_not eq 'all' }
    it { should be_private }
    its('user_ids') { should be_empty }
  end

  describe aws_ebs_snapshot(name: aws_ebs_snapshot_name) do
    it { should exist }
    its('snapshot_id') { should eq aws_ebs_snapshot_id }
    its('tags') { should include(key: 'Name', value: aws_ebs_snapshot_name) }
  end

  describe aws_ebs_snapshot(snapshot_id: aws_ebs_encrypted_snapshot_id) do
    it { should be_encrypted }
    its('encrypted') { should eq true }
  end

  describe aws_ebs_snapshot(name: 'not_existing_volume_name') do
    it { should_not exist }
  end

  # Note: It is not possible to create a public EBS snapshot using terraform.
  # Tests returned expected results after making an EBS snapshot public using the aws cli.
end

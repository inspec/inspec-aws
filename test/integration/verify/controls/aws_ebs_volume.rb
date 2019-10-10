title 'Test single AWS EBS Volume'

aws_ebs_volume_name = attribute(:aws_ebs_volume_name, default: '', description: 'The AWS EBS Volume name.')
aws_ebs_volume_id = attribute(:aws_ebs_volume_id, default: '', description: 'The AWS EBS Volume ID.')

control 'aws-ebs-volume-1.0' do

  impact 1.0
  title 'Ensure AWS EBS Volume has the correct properties.'

  describe aws_ebs_volume(volume_id: aws_ebs_volume_id) do
    it { should exist }
    its ('volume_id') { should eq aws_ebs_volume_id }
    its('tags') { should include(key: 'Name', value: aws_ebs_volume_name) }
    it { should_not be_encrypted }
  end

  describe aws_ebs_volume(aws_ebs_volume_id) do
    it { should exist }
    its ('volume_id') { should eq aws_ebs_volume_id }
    its('tags') { should include(key: 'Name', value: aws_ebs_volume_name) }
    it { should_not be_encrypted }
  end

  describe aws_ebs_volume(name: aws_ebs_volume_name) do
    it { should exist }
    its ('volume_id') { should eq aws_ebs_volume_id }
    its('tags') { should include(key: 'Name', value: aws_ebs_volume_name) }
    it { should_not be_encrypted }
  end

  describe aws_ebs_volume(name: 'not_existing_volume_name') do
    it { should_not exist }
  end

end
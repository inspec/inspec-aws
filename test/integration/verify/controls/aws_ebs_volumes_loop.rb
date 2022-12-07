aws_ebs_volume_id = input(:aws_ebs_volume_id, value: '', description: 'The AWS EBS Volume ID.')
aws_ebs_volume_name = input(:aws_ebs_volume_name, value: '', description: 'The AWS EBS Volume name.')

title 'Test AWS EBS Volumes in bulk using plural and singular resources'

control 'aws-ebs-volumes-loop-1.0' do
  impact 1.0
  title 'Ensure AWS EBS Volumes plural resource using singular resource for detail.'

  aws_ebs_volumes.where { volume_id == aws_ebs_volume_id }.volume_ids.each do |volume|
    describe aws_ebs_volume(volume_id: volume) do
      it { should exist }
      its ('volume_id') { should eq aws_ebs_volume_id }
      its('tags') { should include(key: 'Name', value: aws_ebs_volume_name) }
      it { should_not be_encrypted }
    end
  end
end
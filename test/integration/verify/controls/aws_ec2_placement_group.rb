aws_placement_group_name = input(:aws_placement_group_name, value: '', description: '')
aws_placement_group_placement_group_id = input(:aws_placement_group_placement_group_id, value: '', description: '')

control 'aws-ec2-placement-group-1.0' do
  impact 1.0
  title 'Describes the specified placement groups or all of your placement groups.'

  describe aws_ec2_placement_group(placement_group_name: aws_placement_group_name) do
    it { should exist }
  end

  describe aws_ec2_placement_group(placement_group_name: aws_placement_group_name) do
    its('group_name') { should eq aws_placement_group_name }
    its('state') { should eq 'available' }
    its('strategy') { should eq 'cluster' }
    its('partition_count') { should be_empty }
    its('group_id') { should eq aws_placement_group_placement_group_id }
    its('tags') { should be_empty }
  end

  describe aws_ec2_placement_group(placement_group_name: 'dummy') do
    it { should exist }
  end
end
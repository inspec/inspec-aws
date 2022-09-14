aws_placement_group_name = input(:aws_placement_group_name, value: '', description: '')
aws_placement_group_placement_group_id = input(:aws_placement_group_placement_group_id, value: '', description: '')

control 'aws-ec2-placement-groups-1.0' do
  impact 1.0
  title 'Describes the specified placement groups or all of your placement groups.'

  describe aws_ec2_placement_groups do
    it { should exist }
  end

  describe aws_ec2_placement_groups do
    its('group_names') { should include aws_placement_group_name }
    its('states') { should include 'available' }
    its('strategies') { should include 'cluster' }
    its('partition_counts') { should_not be_empty }
    its('group_ids') { should include aws_placement_group_placement_group_id }
    its('tags') { should_not be_empty }
  end
end

aws_placement_group_name = attribute(:aws_placement_group_name, value: '', description: 'The AWS EC2 Placement groups.')


title 'Test WS EC2 Placement groups in bulk'
control 'aws_placement_group_name-1.0' do

  impact 1.0
  title 'Ensure AWS EC2 Placement groups resource has the correct properties.'

  describe aws_ec2_placement_groups do
    it { should exist }
    its('strategy') { should include "cluster" }
    its('aws_placement_group_name') { should include aws_placement_group_name  }
  end
end

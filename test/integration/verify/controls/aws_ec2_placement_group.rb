aws_placement_group_name = attribute(:aws_placement_group_name, value: '', description: 'The AWS EC2 Placement group.')


title 'Test single AWS EC2 Placement groups'
control 'aws_placement_group_name-1.0' do

  impact 1.0
  title 'Ensure AWS EC2 Placement groups resource has the correct properties.'

  describe aws_ec2_placement_group(group_name: aws_placement_group_name) do
    it { should exist }
    its('strategy') { should eq "cluster" }
    its('aws_placement_group_name') { should eq aws_placement_group_name  }
  end
end

title 'Test single AWS Auto Scaling Group'

group_name = input(:aws_auto_scaling_group, value: '', description: 'The AWS Auto Scaling Group name.')

control 'aws-auto-scaling-group-1.0' do
  impact 1.0
  title 'Ensure AWS Auto Scaling Group has the correct properties.'

  describe aws_auto_scaling_group(auto_scaling_group_name: group_name) do
    it           { should exist }
    its ('name') { should eq group_name}
  end
end

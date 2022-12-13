title 'Test collection of AWS Auto Scaling Groups'

group_name = input(:aws_auto_scaling_group, value: '', description: 'The AWS Auto Scaling Group name.')

control 'aws-auto-scaling-groups-1.0' do
  title 'Ensure AWS Auto Scaling Group plural resource have the correct properties.'

  describe aws_auto_scaling_groups() do
    it            { should exist }
    its ('names') { should eq [group_name]}
  end
end

title 'Test collection of AWS Auto Scaling Groups'

group_name = attribute(:aws_auto_scaling_group, default: '', description: 'The AWS Auto Scaling Group name.')

control 'aws-auto-scaling-groups-1.0' do
  impact 1.0
  title 'Ensure AWS Auto Scaling Group plural resource have the correct properties.'

  describe aws_auto_scaling_groups() do
    it            { should exist }
    its ('names') { should include group_name}
  end
end

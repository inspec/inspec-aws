aws_auto_scaling_group_name = input(:aws_auto_scaling_group_name, value: '', description: '')
aws_auto_scaling_policy_name = input(:aws_auto_scaling_policy_name, value: '', description: '')
aws_auto_scaling_adjustment = input(:aws_auto_scaling_adjustment, value: '', description: '')
aws_auto_scaling_adjustment_type = input(:aws_auto_scaling_adjustment_type, value: '', description: '')
aws_auto_scaling_cooldown = input(:aws_auto_scaling_cooldown, value: '', description: '')

control 'aws-autoscaling-scalable-policies-1.0' do
  impact 1.0
  title 'Describes the policies for the specified Auto Scaling group.'
  
  describe aws_autoscaling_scaling_policies do
    it { should exist }
    its('auto_scaling_group_names') { should include aws_auto_scaling_group_name }
    its('scaling_adjustments') { should include aws_auto_scaling_adjustment }
    its('adjustment_types') { should include aws_auto_scaling_adjustment_type }
    its('cooldowns') { should include aws_auto_scaling_cooldown }
    its('policy_names') { should include aws_auto_scaling_policy_name }
  end
end
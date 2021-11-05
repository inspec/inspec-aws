aws_auto_scaling_group_name = attribute("aws_auto_scaling_group_name", value: "", description: "")
aws_auto_scaling_policy_name = attribute("aws_auto_scaling_policy_name", value: "", description: "")
aws_auto_scaling_adjustment = attribute("aws_auto_scaling_adjustment", value: "", description: "")
aws_auto_scaling_adjustment_type = attribute("aws_auto_scaling_adjustment_type", value: "", description: "")
aws_auto_scaling_cooldown = attribute("aws_auto_scaling_cooldown", value: "", description: "")



control 'aws-autoscaling-scalable-policies-2.0' do
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
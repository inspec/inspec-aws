aws_auto_scaling_group_name = input(:aws_auto_scaling_group_name, value: '', description: '')
aws_auto_scaling_policy_name = input(:aws_auto_scaling_policy_name, value: '', description: '')
aws_auto_scaling_adjustment = input(:aws_auto_scaling_adjustment, value: '', description: '')
aws_auto_scaling_adjustment_type = input(:aws_auto_scaling_adjustment_type, value: '', description: '')
aws_auto_scaling_cooldown = input(:aws_auto_scaling_cooldown, value: '', description: '')

control 'aws-autoscaling-scalable-policy-1.0' do
  impact 1.0
  title 'Describes the policy for the specified Auto Scaling group.'
  
  describe aws_autoscaling_scaling_policy(auto_scaling_group_name: aws_auto_scaling_group_name) do
    it { should exist }
    its('auto_scaling_group_name') { should eq aws_auto_scaling_group_name }
    its('policy_name') { should eq aws_auto_scaling_policy_name }
    its('scaling_adjustment') { should eq aws_auto_scaling_adjustment }
    its('adjustment_type') { should eq aws_auto_scaling_adjustment_type }
    its('cooldown') { should eq aws_auto_scaling_cooldown }
  end
end
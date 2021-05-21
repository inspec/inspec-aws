aws_auto_scaling_group_name = attribute("aws_auto_scaling_group_name", default: "", description: "")
aws_policy_name = attribute("aws_policy_name", default: "", description: "")
aws_policy_arn = attribute("aws_policy_arn", default: "", description: "")
aws_policy_type = attribute("aws_policy_type", default: "", description: "")
aws_adjustment_type = attribute("aws_adjustment_type", default: "", description: "")
aws_min_adjustment_step = attribute("aws_min_adjustment_step", default: "", description: "")
aws_min_adjustment_magnitude = attribute("aws_min_adjustment_magnitude", default: "", description: "")
aws_scaling_adjustment = attribute("aws_scaling_adjustment", default: "", description: "")
aws_cooldown = attribute("aws_cooldown", default: "", description: "")
aws_step_adjustments = attribute("aws_step_adjustments", default: "", description: "")
aws_metric_aggregation_type = attribute("aws_metric_aggregation_type", default: "", description: "")
aws_estimated_instance_warmup = attribute("aws_estimated_instance_warmup", default: "", description: "")

control 'aws-autoscaling-scalable-policy-1.0' do
  impact 1.0
  title 'Describes the policies for the specified Auto Scaling group.'
  describe aws_autoscaling_scaling_policy(auto_scaling_group_name: aws_auto_scaling_group_name) do
    it { should exist }
    its('auto_scaling_group_name') { should eq aws_auto_scaling_group_name }
    its('policy_name') { should eq aws_policy_name }
    its('policy_arn') { should eq aws_policy_arn }
    its('policy_type') { should eq aws_policy_type }
    its('adjustment_type') { should be_empty }
    its('min_adjustment_step') { should be_empty }
    its('min_adjustment_magnitude') { should be_empty }
    its('scaling_adjustment') { should be_empty }
    its('cooldown') { should be_empty }
    its('step_adjustments') { should be_empty }
    its('metric_aggregation_type') { should be_empty }
    its('estimated_instance_warmup') { should eq aws_estimated_instance_warmup }
    its('target_tracking_configuration') { should eq "" }
  end
end
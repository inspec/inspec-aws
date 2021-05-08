aws_auto_scaling_group_name = attribute("aws_auto_scaling_group_name", default: "aws-auto-scaling-group-itdhguttjriwzrgctzycnqqlo", description: "")
aws_policy_name = attribute("aws_policy_name", default: "AutoScaling-ScalingGroup-9bec71e0-31c8-4c42-9985-5de77b3e0408", description: "")
aws_policy_arn = attribute("aws_policy_arn", default: "arn:aws:autoscaling:us-east-2:112758395563:scalingPolicy:6e3255eb-9584-40f5-966e-3289c26ebeb2:autoScalingGroupName/aws-auto-scaling-group-itdhguttjriwzrgctzycnqqlo:policyName/AutoScaling-ScalingGroup-9bec71e0-31c8-4c42-9985-5de77b3e0408", description: "")
aws_policy_type = attribute("aws_policy_type", default: "TargetTrackingScaling", description: "")
aws_adjustment_type = attribute("aws_adjustment_type", default: "", description: "")
aws_min_adjustment_step = attribute("aws_min_adjustment_step", default: "", description: "")
aws_min_adjustment_magnitude = attribute("aws_min_adjustment_magnitude", default: "", description: "")
aws_scaling_adjustment = attribute("aws_scaling_adjustment", default: "", description: "")
aws_cooldown = attribute("aws_cooldown", default: "", description: "")
aws_step_adjustments = attribute("aws_step_adjustments", default: "", description: "")
aws_metric_aggregation_type = attribute("aws_metric_aggregation_type", default: "", description: "")
aws_estimated_instance_warmup = attribute("aws_estimated_instance_warmup", default: 300, description: "")


control 'aws-autoscaling-scalable-policies-1.0' do
  impact 1.0
  title 'Describes the policies for the specified Auto Scaling group.'
  describe aws_autoscaling_scaling_policies do
    it { should exist }
    its('auto_scaling_group_names') { should include aws_auto_scaling_group_name }
    its('policy_names') { should include aws_policy_name }
    its('policy_arns') { should include aws_policy_arn }
    its('policy_types') { should include aws_policy_type }
    its('estimated_instance_warmups') { should include aws_estimated_instance_warmup }
    its('target_tracking_configurations') { should_not be_empty }
  end
end
control 'aws-application-autoscaling-scalable-policy' do
  impact 1.0
  title 'Ensure Application AutoScaling Policy resource has the correct properties.'
  
  describe aws_application_autoscaling_scaling_policy(service_namespace: 'dynamodb') do
    it { should exist }
  end

  describe aws_application_autoscaling_scaling_policy( service_namespace: 'dynamodb' ) do
    its('policy_arn') { should_not be_empty }
    its('policy_name') { should eq 'DynamoDBReadCapacityUtilization:table/GameScores' }
    its('service_namespace') { should eq 'dynamodb' }
    its('resource_id') { should eq 'table/GameScores' }
    its('scalable_dimension') { should eq 'dynamodb:table:ReadCapacityUnits' }
    its('policy_type') { should eq 'TargetTrackingScaling' }


    its('step_scaling_policy_configuration.adjustment_type') { should be_empty }
    its('step_scaling_policy_configuration.step_adjustments.first.metric_interval_lower_bound') { should be_empty }
    its('step_scaling_policy_configuration.step_adjustments.first.metric_interval_upper_bound') { should be_empty }
    its('step_scaling_policy_configuration.step_adjustments.first.scaling_adjustment') { should be_empty }
    its('step_scaling_policy_configuration.min_adjustment_magnitude') { should be_empty }
    its('step_scaling_policy_configuration.cooldown') { should be_empty }
    its('step_scaling_policy_configuration.metric_aggregation_type') { should be_empty }

    its('target_tracking_scaling_policy_configuration.target_value') { should be_empty }
    its('target_tracking_scaling_policy_configuration.predefined_metric_specification.predefined_metric_type') { should eq 'DynamoDBReadCapacityUtilization' }
    its('target_tracking_scaling_policy_configuration.predefined_metric_specification.resource_label') { should be_empty }
    its('target_tracking_scaling_policy_configuration.customized_metric_specification.metric_name') { should be_empty }
    its('target_tracking_scaling_policy_configuration.customized_metric_specification.namespace') { should be_empty }
    its('target_tracking_scaling_policy_configuration.customized_metric_specification.dimensions.first.name') { should be_empty }
    its('target_tracking_scaling_policy_configuration.customized_metric_specification.dimensions.first.value') { should be_empty }
    its('target_tracking_scaling_policy_configuration.customized_metric_specification.statistic') { should be_empty }
    its('target_tracking_scaling_policy_configuration.customized_metric_specification.unit') { should be_empty }
    its('target_tracking_scaling_policy_configuration.scale_out_cooldown') { should eq 0 }
    its('target_tracking_scaling_policy_configuration.scale_in_cooldown') { should eq 0 }
    its('target_tracking_scaling_policy_configuration.disable_scale_in') { should eq false }

    its('alarms.first.alarm_name') { should_not be_empty }
    its('alarms.first.alarm_arn') { should_not be_empty }
  end
end
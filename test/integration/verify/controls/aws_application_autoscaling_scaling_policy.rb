describe aws_application_autoscaling_scaling_policy(service_namespace: 'dynamodb') do
  it { should exist }
end

describe aws_application_autoscaling_scaling_policy( service_namespace: 'dynamodb' ) do
  its('policy_arn') { should eq 'arn:aws:autoscaling:us-east-2:112758395563:scalingPolicy:6065ea3e-f18a-47d2-9d07-a7606b0ee5aa:resource/dynamodb/table/GameScores:policyName/DynamoDBReadCapacityUtilization:table/GameScores' }
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

  its('alarms.first.alarm_name') { should eq 'TargetTracking-table/GameScores-AlarmHigh-c6274d62-ea80-4f6b-add4-c7d8232cac74' }
  its('alarms.first.alarm_arn') { should eq 'arn:aws:cloudwatch:us-east-2:112758395563:alarm:TargetTracking-table/GameScores-AlarmHigh-c6274d62-ea80-4f6b-add4-c7d8232cac74' }
end
describe aws_application_autoscaling_scaling_policies(service_namespace: 'dynamodb') do
  it { should exist }
end

describe aws_application_autoscaling_scaling_policies( service_namespace: 'dynamodb' ) do
  its('policy_arns') { should include 'arn:aws:autoscaling:us-east-2:112758395563:scalingPolicy:6065ea3e-f18a-47d2-9d07-a7606b0ee5aa:resource/dynamodb/table/GameScores:policyName/DynamoDBReadCapacityUtilization:table/GameScores' }
  its('policy_names') { should include 'DynamoDBReadCapacityUtilization:table/GameScores' }
  its('service_namespaces') { should include 'dynamodb' }
  its('resource_ids') { should include 'table/GameScores' }
  its('scalable_dimensions') { should include 'dynamodb:table:ReadCapacityUnits' }
  its('policy_types') { should include 'TargetTrackingScaling' }
  its('step_scaling_policy_configurations')  { should_not be_empty }
  its('target_tracking_scaling_policy_configurations') { should_not be_empty }
  its('alarms') { should_not be_empty }
  its('creation_times') { should_not be_empty }
end












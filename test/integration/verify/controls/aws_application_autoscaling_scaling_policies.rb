control 'aws-application-autoscaling-scalable-policies' do
  impact 1.0
  title 'Ensure Application AutoScaling Policies resource has the correct properties.'
  
  describe aws_application_autoscaling_scaling_policies(service_namespace: 'dynamodb') do
    it { should exist }
  end

  describe aws_application_autoscaling_scaling_policies( service_namespace: 'dynamodb' ) do
    its('policy_arns') { should_not be_empty  }
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
end
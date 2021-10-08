describe aws_application_autoscaling_scalable_targets( service_namespace: 'dynamodb' ) do
  it { should exist }
end

describe aws_application_autoscaling_scalable_targets( service_namespace: 'dynamodb' ) do
  its('service_namespaces') { should include 'dynamodb' }
  its('resource_ids') { should include 'table/GameScores' }
  its('scalable_dimensions') { should include 'dynamodb:table:ReadCapacityUnits' }
  its('min_capacities') { should include 5 }
  its('max_capacities') { should include 100 }
  its('role_arns') { should include 'arn:aws:iam::112758395563:role/aws-service-role/dynamodb.application-autoscaling.amazonaws.com/AWSServiceRoleForApplicationAutoScaling_DynamoDBTable' }
  its('suspended_states') { should_not be_empty }
end
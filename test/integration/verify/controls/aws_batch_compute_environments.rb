aws_compute_environment_name = attribute("aws_compute_environment_name", default: "test1", description: "")
aws_compute_environment_arn = attribute("aws_compute_environment_arn", default: "arn:aws:batch:us-east-2:112758395563:compute-environment/test1", description: "")
aws_ecs_cluster_arn = attribute("aws_ecs_cluster_arn", default: "arn:aws:ecs:us-east-2:112758395563:cluster/AWSBatch-test1-1a6929d6-f62b-3d45-b3b5-31e7f64ae0da", description: "")
aws_tags = attribute("aws_tags", default: "test1", description: "")
aws_type = attribute("aws_type", default: "MANAGED", description: "")
aws_state = attribute("aws_state", default: "ENABLED", description: "")
aws_status = attribute("aws_status", default: "VALID", description: "")
aws_status_reason = attribute("aws_status_reason", default: "ComputeEnvironment Healthy", description: "")
aws_service_role = attribute("aws_service_role", default: "arn:aws:iam::112758395563:role/aws-service-role/batch.amazonaws.com/AWSServiceRoleForBatch", description: "")


describe aws_batch_compute_environments do
  it { should exist }
  its('compute_environment_names') { should include aws_compute_environment_name }
  its('compute_environment_arns') { should include aws_compute_environment_arn }
  its('ecs_cluster_arns') { should include aws_ecs_cluster_arn }
  its('tags') { should_not be_empty  }
  its('types') { should include aws_type }
  its('states') { should include aws_state }
  its('statuses') { should include aws_status }
  its('status_reasons') { should include aws_status_reason }
  its('service_roles') { should include aws_service_role }
end
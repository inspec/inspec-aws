aws_compute_environment_name = attribute("aws_compute_environment_name", default: "", description: "")
aws_compute_environment_arn = attribute("aws_compute_environment_arn", default: "", description: "")
aws_ecs_cluster_arn = attribute("aws_ecs_cluster_arn", default: "", description: "")
aws_tags = attribute("aws_tags", default: "", description: "")
aws_type = attribute("aws_type", default: "", description: "")
aws_state = attribute("aws_state", default: "", description: "")
aws_status = attribute("aws_status", default: "", description: "")
aws_status_reason = attribute("aws_status_reason", default: "", description: "")
aws_service_role = attribute("aws_service_role", default: "", description: "")


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
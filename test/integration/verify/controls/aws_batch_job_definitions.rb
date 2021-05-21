aws_job_definition_name = attribute("aws_job_definition_name", default: "test1", description: "")
aws_job_definition_arn = attribute("aws_job_definition_arn", default: "arn:aws:batch:us-east-2:112758395563:job-definition/test1:1", description: "")
aws_revision = attribute("aws_revision", default: 1, description: "")
aws_status = attribute("aws_status", default: "ACTIVE", description: "")
aws_type = attribute("aws_type", default: "container", description: "")
aws_parameters = attribute("aws_parameters", default: "", description: "")
aws_propagate_tags = attribute("aws_propagate_tags", default: false, description: "")
aws_platform_capabilities = attribute("aws_job_definition_name", default: "FARGATE", description: "")


describe aws_batch_job_definitions do
  it { should exist }
  its('job_definition_names') { should include aws_job_definition_name }
  its('job_definition_arns') { should include aws_job_definition_arn }
  its('revisions') { should include aws_revision }
  its('statuses') { should include aws_status }
  its('types') { should include aws_type }
  its('parameters') { should_not be_empty }
  its('tags') { should_not be_empty }
  its('propagate_tags') { should include aws_propagate_tags }
  its('platform_capabilities') { should include [aws_platform_capabilities] }
end
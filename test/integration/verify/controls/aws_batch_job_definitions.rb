aws_job_definition_name = attribute("aws_batch_job_name", value: "", description: "")
aws_job_definition_arn = attribute("aws_batch_job_arn", value: "", description: "")
aws_revision = attribute("aws_batch_job_revision", value: "", description: "")
aws_status = attribute("aws_status", value: "", description: "")
aws_type = attribute("aws_batch_job_type", value: "", description: "")

describe aws_batch_job_definitions do
  it { should exist }
  its('job_definition_names') { should include aws_job_definition_name }
  its('job_definition_arns') { should include aws_job_definition_arn }
  its('revisions') { should include aws_revision }
  its('statuses') { should include aws_status }
  its('types') { should include aws_type }
end
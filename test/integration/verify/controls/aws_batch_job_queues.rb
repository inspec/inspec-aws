aws_job_queue_name = attribute("aws_job_queue_name", default: "test1", description: "")
aws_job_queue_arn = attribute("aws_job_queue_arn", default: "arn:aws:batch:us-east-2:112758395563:job-queue/test1", description: "")
aws_state = attribute("aws_state", default: "ENABLED", description: "")
aws_status = attribute("aws_status", default: "VALID", description: "")
aws_status_reason = attribute("aws_status_reason", default: "JobQueue Healthy", description: "")
aws_priority = attribute("aws_priority", default: 1, description: "")
aws_compute_environment_order = attribute("aws_compute_environment_order", default: 1, description: "")
aws_compute_environment_compute_environment = attribute("aws_compute_environment_compute_environment", default: "arn:aws:batch:us-east-2:112758395563:compute-environment/test1", description: "")
aws_tags = attribute("aws_tags", default: "", description: "")

describe aws_batch_job_queues do
  it { should exist }
  its('job_queue_names') { should include aws_job_queue_name }
  its('job_queue_arns') { should include aws_job_queue_arn }
  its('states') { should include aws_state }
  its('statuses') { should include aws_status }
  its('status_reasons') { should include aws_status_reason }
  its('priorities') { should include aws_priority }
  its('tags') { should_not be_empty }
end
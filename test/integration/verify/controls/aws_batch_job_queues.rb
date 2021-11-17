aws_job_queue_name = attribute("aws_batch_job_queue_name", value: "", description: "")
aws_job_queue_arn = attribute("batch_job_queue_arn", value: "", description: "")
aws_state = attribute("aws_batch_job_queue_status", value: "", description: "")
aws_priority = attribute("aws_batch_job_queue_priority", value: 1, description: "")
aws_compute_environment_compute_environment = attribute("batch_job_queue_compute_environments", value: "", description: "")

describe aws_batch_job_queues do
  it { should exist }
  its('job_queue_names') { should include aws_job_queue_name }
  its('job_queue_arns') { should include aws_job_queue_arn }
  its('states') { should include aws_state }
  its('priorities') { should include aws_priority }
  its('compute_environment_order.first.compute_environments') { should be <= 1 }
end
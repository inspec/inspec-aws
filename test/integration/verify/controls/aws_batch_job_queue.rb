aws_job_queue_name = attribute("aws_job_queue_name", default: "test1", description: "")
aws_job_queue_arn = attribute("aws_job_queue_arn", default: "arn:aws:batch:us-east-2:112758395563:job-queue/test1", description: "")
aws_state = attribute("aws_state", default: "ENABLED", description: "")
aws_status = attribute("aws_status", default: "VALID", description: "")
aws_status_reason = attribute("aws_status_reason", default: "JobQueue Healthy", description: "")
aws_priority = attribute("aws_priority", default: 1, description: "")
aws_compute_environment_order = attribute("aws_compute_environment_order", default: 1, description: "")
aws_compute_environment_compute_environment = attribute("aws_compute_environment_compute_environment", default: "arn:aws:batch:us-east-2:112758395563:compute-environment/test1", description: "")
aws_tags = attribute("aws_tags", default: "", description: "")

describe aws_batch_job_queue(job_queue_name: 'test1') do
  it { should exist }
  its('job_queue_name') { should eq aws_job_queue_name }
  its('job_queue_arn') { should eq aws_job_queue_arn }
  its('state') { should eq aws_state }
  its('status') { should eq aws_status }
  its('status_reason') { should eq aws_status_reason }
  its('priority') { should eq aws_priority }
  its('compute_environment_order.first.order') { should eq aws_compute_environment_order }
  its('compute_environment_order.first.compute_environment') { should eq aws_compute_environment_compute_environment }
  its('tags') { should be_empty }
end
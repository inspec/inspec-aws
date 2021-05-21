aws_job_queue_name = attribute("aws_job_queue_name", default: "", description: "")
aws_job_queue_arn = attribute("aws_job_queue_arn", default: "", description: "")
aws_state = attribute("aws_state", default: "", description: "")
aws_status = attribute("aws_status", default: "", description: "")
aws_status_reason = attribute("aws_status_reason", default: "", description: "")
aws_priority = attribute("aws_priority", default: 1, description: "")
aws_compute_environment_order = attribute("aws_compute_environment_order", default: 1, description: "")
aws_compute_environment_compute_environment = attribute("aws_compute_environment_compute_environment", default: "", description: "")
aws_tags = attribute("aws_tags", default: "", description: "")

describe aws_batch_job_queue(job_queue_name: aws_job_queue_name) do
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
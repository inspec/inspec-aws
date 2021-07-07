aws_job_queue_name = attribute("aws_batch_job_queue_name", default: "", description: "")
aws_job_queue_arn = attribute("batch_job_queue_arn", default: "", description: "")
aws_state = attribute("aws_batch_job_queue_status", default: "", description: "")
aws_priority = attribute("aws_batch_job_queue_priority", default: 1, description: "")
aws_compute_environment_compute_environment = attribute("batch_job_queue_compute_environments", default: "", description: "")


describe aws_batch_job_queue(job_queue_name: aws_job_queue_name) do
  it { should exist }
  its('job_queue_name') { should eq aws_job_queue_name }
  its('job_queue_arn') { should eq aws_job_queue_arn }
  its('state') { should eq aws_state }
  its('priority') { should eq aws_priority }
  its('compute_environment_order.first.compute_environment') { should_not be_empty }
end
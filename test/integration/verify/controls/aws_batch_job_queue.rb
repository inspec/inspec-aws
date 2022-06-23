aws_job_queue_name = input(:aws_batch_job_queue_name, value: '', description: '')
aws_job_queue_arn = input(:batch_job_queue_arn, value: '', description: '')
aws_state = input(:aws_batch_job_queue_status, value: '', description: '')
aws_priority = input(:aws_batch_job_queue_priority, value: 1, description: '')
aws_compute_environment_compute_environment = input(:batch_job_queue_compute_environments, value: '', description: '')

control 'aws-batch-job-queue-1.0' do
  impact 1.0
  title 'Ensure AWS Batch Job Queue has the correct properties.'
  
  describe aws_batch_job_queue(job_queue_name: aws_job_queue_name) do
    it { should exist }
    its('job_queue_name') { should eq aws_job_queue_name }
    its('job_queue_arn') { should eq aws_job_queue_arn }
    its('state') { should eq aws_state }
    its('priority') { should eq aws_priority }
    its('compute_environment_order.first.compute_environment') { should_not be_empty }
  end
end
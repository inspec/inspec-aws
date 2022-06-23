aws_job_queue_name = input(:aws_batch_job_queue_name, value: '', description: '')
aws_job_queue_arn = input(:batch_job_queue_arn, value: '', description: '')
aws_state = input(:aws_batch_job_queue_status, value: '', description: '')
aws_priority = input(:aws_batch_job_queue_priority, value: 1, description: '')
aws_compute_environment_compute_environment = input(:batch_job_queue_compute_environments, value: '', description: '')

control 'aws-batch-job-queues-1.0' do
  impact 1.0
  title 'Ensure AWS Batch Job Queues has the correct properties.'
  
  describe aws_batch_job_queues do
    it { should exist }
    its('job_queue_names') { should include aws_job_queue_name }
    its('job_queue_arns') { should include aws_job_queue_arn }
    its('states') { should include aws_state }
    its('priorities') { should include aws_priority }
    its('compute_environment_order.first.compute_environments') { should be <= 1 }
  end
end
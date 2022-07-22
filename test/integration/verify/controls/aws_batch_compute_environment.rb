aws_compute_environment_name = input(:aws_compute_environment_name, value: '', description: '')
aws_state = input(:aws_batch_job_queue_status, value: '', description: '')
aws_compute_resources_type = input(:aws_type, value: '', description: '')
aws_compute_resources_minv_cpus = input(:aws_min_vcpus, value: '', description: '')
aws_compute_resources_maxv_cpus = input(:aws_max_vcpus, value: '', description: '')

control 'aws-batch-compute-environment-1.0' do
  impact 1.0
  title 'Test the properties of Batch Compute Environment.'

  describe aws_batch_compute_environment(compute_environment_name: aws_compute_environment_name) do
    it { should exist }
    its('compute_environment_name') { should eq aws_compute_environment_name }
    its('type') { should eq 'MANAGED' }
    its('state') { should eq aws_state }
    its('status') { should eq 'VALID' }
    its('status_reason') { should eq  'ComputeEnvironment Healthy'}
    its('compute_resources.type') { should eq aws_compute_resources_type }
    its('compute_resources.allocation_strategy') { should be_empty }
    its('compute_resources.minv_cpus') { should eq aws_compute_resources_minv_cpus  }
    its('compute_resources.maxv_cpus') { should eq aws_compute_resources_maxv_cpus }
  end
end
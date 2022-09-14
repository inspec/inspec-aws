aws_job_definition_name = input(:aws_batch_job_name, value: '', description: '')
aws_job_definition_arn = input(:aws_batch_job_arn, value: '', description: '')
aws_revision = input(:aws_batch_job_revision, value: '', description: '')
aws_status = input(:aws_status, value: '', description: '')
aws_type = input(:aws_batch_job_id, value: '', description: '')

control 'aws-batch-job-definition-1.0' do
  impact 1.0
  title 'Test the properties of Batch Job Definition.'

  describe aws_batch_job_definition(job_definition_name: aws_job_definition_name) do
    it { should exist }
    its('job_definition_name') { should eq aws_job_definition_name }
    its('job_definition_arn') { should eq aws_job_definition_arn }
    its('revision') { should eq aws_revision }
    its('status') { should eq aws_status }
    its('type') { should eq aws_type }
    its('parameters') { should be_empty }
  end
end
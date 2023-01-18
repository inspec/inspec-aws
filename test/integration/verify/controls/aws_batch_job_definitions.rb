aws_job_definition_name = input(:aws_batch_job_name, value: '', description: '')
aws_job_definition_arn = input(:aws_batch_job_arn, value: '', description: '')
aws_revision = input(:aws_batch_job_revision, value: '', description: '')
aws_status = input(:aws_status, value: '', description: '')
aws_type = input(:aws_batch_job_id, value: '', description: '')

control 'aws-batch-job-definitions-1.0' do
  title 'Test the properties of Batch Job Definitions.'

  describe aws_batch_job_definitions do
    it { should exist }
    its('job_definition_names') { should include aws_job_definition_name }
    its('job_definition_arns') { should include aws_job_definition_arn }
    its('revisions') { should include aws_revision }
    its('statuses') { should include aws_status }
    its('types') { should include aws_type }
  end
end

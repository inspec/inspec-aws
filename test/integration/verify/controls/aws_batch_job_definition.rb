aws_job_definition_name = attribute("aws_batch_job_name", default: "test1", description: "")
aws_job_definition_arn = attribute("aws_batch_job_arn", default: "arn:aws:batch:us-east-2:112758395563:job-definition/test1:1", description: "")
aws_revision = attribute("aws_batch_job_revision", default: 1, description: "")
aws_status = attribute("aws_status", default: "ACTIVE", description: "")
aws_type = attribute("aws_batch_job_id", default: "container", description: "")




describe aws_batch_job_definition(job_definition_name: aws_job_definition_name) do
  it { should exist }
  its('job_definition_name') { should eq aws_job_definition_name }
  its('job_definition_arn') { should eq aws_job_definition_arn }
  its('revision') { should eq aws_revision }
  its('status') { should eq aws_status }
  its('type') { should eq aws_type }
  its('parameters') { should be_empty }
end
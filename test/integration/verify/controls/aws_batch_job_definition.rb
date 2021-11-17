aws_job_definition_name = attribute("aws_batch_job_name", value: "", description: "")
aws_job_definition_arn = attribute("aws_batch_job_arn", value: "", description: "")
aws_revision = attribute("aws_batch_job_revision", value: "", description: "")
aws_status = attribute("aws_status", value: "", description: "")
aws_type = attribute("aws_batch_job_id", value: "", description: "")

describe aws_batch_job_definition(job_definition_name: aws_job_definition_name) do
  it { should exist }
  its('job_definition_name') { should eq aws_job_definition_name }
  its('job_definition_arn') { should eq aws_job_definition_arn }
  its('revision') { should eq aws_revision }
  its('status') { should eq aws_status }
  its('type') { should eq aws_type }
  its('parameters') { should be_empty }
end
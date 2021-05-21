aws_name = attribute("aws_name", default: "", description: "")
aws_state = attribute("aws_state", default: "", description: "")
aws_description = attribute("aws_description", default: "", description: "")
aws_creation_time = attribute("aws_creation_time", default: "", description: "")

describe aws_athena_work_groups do
  it { should exist }
  its('count') { should eq 2 }
  its('names') { should include aws_name }
  its('states') { should include aws_state }
  its('descriptions') { should include aws_description }
  # its('creation_times') { should be_empty }
end

aws_athena_workgroup= attribute("aws_athena_workgroup", default: "", description: "")
aws_state = attribute("aws_athena_workgroup_state", default: "", description: "")
aws_description = attribute("aws_athena_workgroup_description", default: "", description: "")

describe aws_athena_work_groups do
  it { should exist }
  its('count') { should >= 1 }
  its('names') { should include aws_athena_workgroup }
  its('states') { should include aws_state }
  its('descriptions') { should include aws_description }
end

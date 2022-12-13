aws_athena_workgroup = input(:aws_athena_workgroup, value: '', description: '')
aws_state = input(:aws_athena_workgroup_state, value: '', description: '')
aws_description = input(:aws_athena_workgroup_description, value: '', description: '')

control 'aws-athena-work-groups-1.0' do
  title 'Test the properties of Athena Work Groups.'

  describe aws_athena_work_groups do
    its('count') { should >= 1 }
    it { should exist }
  end

  describe aws_athena_work_groups do
    its('names') { should include aws_athena_workgroup }
    its('states') { should include aws_state }
    its('descriptions') { should include aws_description }
  end
end

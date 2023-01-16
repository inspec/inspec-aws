aws_sfn_state_machine_name = input(:aws_sfn_state_machine_name, value: '', description: '')
aws_sfn_state_machine_arn = input(:aws_sfn_state_machine_arn, value: '', description: '')

control 'aws-state-resource-state-machines-1.0' do
  title 'Ensure AWS State Resource State Machines has current properties'

  describe aws_stepfunctions_state_machines do
    it { should exist }
  end

  describe aws_stepfunctions_state_machines do
    its('state_machine_arns') { should include aws_sfn_state_machine_arn }
    its('names') { should include aws_sfn_state_machine_name }
    its('types') { should include 'STANDARD' }
    its('creation_dates') { should_not be_empty }
  end
end

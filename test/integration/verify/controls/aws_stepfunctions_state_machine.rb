aws_sfn_state_machine_name = input(:aws_sfn_state_machine_name, value: '', description: '')
aws_sfn_state_machine_arn = input(:aws_sfn_state_machine_arn, value: '', description: '')
aws_sfn_state_machine_role_arn = input(:aws_sfn_state_machine_role_arn, value: '', description: '')

control 'aws-state-resource-state-machine-1.0' do
  title 'Ensure AWS State Resource State Machine has current properties'

  describe aws_stepfunctions_state_machine(state_machine_arn: aws_sfn_state_machine_arn) do
    it { should exist }
  end

  describe aws_stepfunctions_state_machine(state_machine_arn: aws_sfn_state_machine_arn) do
    its('state_machine_arn') { should eq aws_sfn_state_machine_arn }
    its('name') { should eq aws_sfn_state_machine_name }
    its('status') { should eq "ACTIVE" }
    its('definition') { should_not be_empty }
    its('role_arn') { should eq aws_sfn_state_machine_role_arn }
    its('type') { should eq 'STANDARD' }
    its('logging_configuration.level') { should eq 'OFF' }
    its('logging_configuration.include_execution_data') { should eq false }
    its('logging_configuration.destinations') { should be_empty }
    its('logging_configuration.destinations.first.cloud_watch_logs_log_group.log_group_arn') { should be_empty }
    its('tracing_configuration.enabled') { should eq false }
  end
end

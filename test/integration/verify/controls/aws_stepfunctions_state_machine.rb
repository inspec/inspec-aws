control 'aws-state-resource-state-machine-1.0' do

    impact 1.0
    title 'Ensure AWS State Resource State Machine has current properties'
  
    describe aws_stepfunctions_state_machine(state_machine_arn: "arn:aws:states:us-east-2:112758395563:stateMachine:test1") do
        it { should exist }
    end
end

control 'aws-state-resource-state-machine-1.0' do

    impact 1.0
    title 'Ensure AWS State Resource State Machine has current properties'
  
    describe aws_stepfunctions_state_machine(state_machine_arn: "arn:aws:states:us-east-2:112758395563:stateMachine:test1") do
        its('state_machine_arn') { should eq 'arn:aws:states:us-east-2:112758395563:stateMachine:test1' }
        its('name') { should eq 'test1' }
        its('status') { should eq 'ACTIVE' }
        its('definition') { should_not be_empty }
        its('role_arn') { should eq 'arn:aws:iam::112758395563:role/service-role/StepFunctions-test1-role-1b5b2c92' }
        its('type') { should eq 'STANDARD' }
        its('logging_configuration.level') { should eq 'OFF' }
        its('logging_configuration.include_execution_data') { should eq false }
        its('logging_configuration.destinations') { should be_empty }
        its('logging_configuration.destinations.first.cloud_watch_logs_log_group.log_group_arn') { should be_empty }
        its('tracing_configuration.enabled') { should eq false }
    end
end
control 'aws-state-resource-state-machines-1.0' do

    impact 1.0
    title 'Ensure AWS State Resource State Machines has current properties'
  
    describe aws_stepfunctions_state_machines do
        it { should exist }
    end
end

control 'aws-state-resource-state-machines-1.0' do

    impact 1.0
    title 'Ensure AWS State Resource State Machines has current properties'
  
    describe aws_stepfunctions_state_machines do
        its('state_machine_arns') { should include 'arn:aws:states:us-east-2:112758395563:stateMachine:test1' }
        its('names') { should include 'test1' }
        its('types') { should include 'STANDARD' }
        its('creation_dates') { should_not be_empty }
    end
end
describe aws_eventbridge_rules do
    it { should exist }
  end
  
  describe aws_eventbridge_rules do
    its('names') { should include 'Autotagger_rule' }
    its('arns') { should include 'arn:aws:events:us-east-2:112758395563:rule/Autotagger_rule' }
    its('event_patterns') { should_not be_empty }
    its('states') { should include 'ENABLED' }
    its('descriptions') { should be_empty }
    its('schedule_expressions') { should be_empty }
    its('role_arns') { should be_empty }
    its('managed_bys') { should be_empty }
    its('event_bus_names') { should include 'default' }
  end
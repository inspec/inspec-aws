describe aws_eventbridge_rule(name: 'Autotagger_rule') do
    it { should exist }
  end
  
  describe aws_eventbridge_rule(name: 'Autotagger_rule') do
    its('name') { should eq 'Autotagger_rule' }
    its('arn') { should eq 'arn:aws:events:us-east-2:112758395563:rule/Autotagger_rule' }
    its('event_pattern') { should_not be_empty }
    its('state') { should eq 'ENABLED' }
    its('description') { should be_empty }
    its('schedule_expression') { should be_empty }
    its('role_arn') { should be_empty }
    its('managed_by') { should be_empty }
    its('event_bus_name') { should eq 'default' }
  end